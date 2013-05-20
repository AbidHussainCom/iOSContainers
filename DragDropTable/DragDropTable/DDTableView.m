//
//  DDTableView.m
//  DragDropTable
//
//  Created by Hari Kunwar on 5/18/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "DDTableView.h"
#import "DDTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DDTableView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableArray *reusableCells;//Ordered top to bottom
@property (nonatomic, assign) NSInteger totalCellCount;
@property (nonatomic, assign) CGPoint scrollViewOffset;


@end

@implementation DDTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _scrollViewOffset = CGPointMake(0, 0);
    }
    return self;
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
    DDTableViewCell *reusableCell = nil;

    for(DDTableViewCell *tableCell in _reusableCells){
        BOOL tableCellOffScreen = ! CGRectIntersectsRect(_scrollView.bounds, tableCell.frame);
        if(tableCellOffScreen && [tableCell.reuseIdentifier isEqualToString:identifier]){
            reusableCell = tableCell;
            break;
        }
    }
    
    return reusableCell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_sections == nil){
        NSInteger numberOfSections = [self numberOfSections];
        _sections = [self sectionsWithCapacity:numberOfSections];
        
        //Create screenful of content
        _reusableCells = [self reusableCells];
        
        _totalCellCount = [self totalCellCount];
        
        _scrollView.contentSize = [self contentSize];
        
        [self layoutCells];
    }
}

- (void)layoutCells
{
    for(DDTableViewCell *tableCell in _reusableCells){
        [_scrollView addSubview:tableCell];
        
        tableCell.frame = [self tableCellFrameWithIndexPath:tableCell.indexPath];
    }
}

- (void)layoutButtonCells
{
    NSInteger bottomIndex = [_reusableCells count] - 1;
    DDTableViewCell *tableCell = [_reusableCells objectAtIndex:bottomIndex];
    
    tableCell.frame = [self tableCellFrameWithIndexPath:tableCell.indexPath];    
}

- (CGSize)contentSize
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = 0.0f;
    
    for(int i = 0; i < [_sections count]; i++){
        
        NSInteger numberOfRows = [[_sections objectAtIndex:i] intValue];
        
        for(int j = 0; j < numberOfRows; j++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];

            if([_delegate respondsToSelector:@selector(DDTableView:heightForRowAtIndexPath:)]){
               height = height + [_delegate DDTableView:self heightForRowAtIndexPath:indexPath];
            }
        }
    }
    
    CGSize contentSize = CGSizeMake(width, height);
    
    return contentSize;
}

#pragma mark - TableView Sections

- (NSInteger)numberOfSections
{
    NSInteger numberOfSections = 1;
    if([_dataSource respondsToSelector:@selector(numberOfSectionsInDDTableView:)]){
        numberOfSections = [_dataSource numberOfSectionsInDDTableView:self];
    }
    return numberOfSections;
}

- (NSMutableArray *)sectionsWithCapacity:(NSInteger)numberOfSections
{
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:numberOfSections];
    //Number of rows in a section
    for(int i = 0; i < numberOfSections; i++){
        
        NSInteger numberOfRowsInSection = [_dataSource DDTableView:self numberOfRowsInSection:i];
        NSNumber *numberObject = [NSNumber numberWithInt:numberOfRowsInSection];
        
        [sections insertObject:numberObject atIndex:i];
    }
    
    return sections;
}

#pragma mark - ReusableCells

- (NSMutableArray *)reusableCells
{
    NSInteger reusableCellCount = [self reusableCellCount];

    NSMutableArray *reusableCells = [[NSMutableArray alloc] initWithCapacity:reusableCellCount];
    
    NSInteger cellCount = 0;
    
    for(int i = 0; i < [_sections count]; i++){
        NSInteger numberOfRows = [[_sections objectAtIndex:i] intValue];
        
        for(int j = 0; j < numberOfRows; j++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            if( [_delegate respondsToSelector:@selector(DDTableView:cellForRowAtIndexPath:)]){
                DDTableViewCell *tableCell = [_dataSource DDTableView:self cellForRowAtIndexPath:indexPath];
                tableCell.indexPath = indexPath;

                [reusableCells insertObject:tableCell atIndex:cellCount];
                
                cellCount++;
                
                if(cellCount > reusableCellCount)
                    return reusableCells;
            }
        }
        
    }
    
    return reusableCells;
}

- (void)addCellWithIndexPath:(NSIndexPath *)indexPath atTop:(BOOL)top
{
//    DDTableViewCell *topCell = [_reusableCells objectAtIndex:0];
    DDTableViewCell *tableCell = [_dataSource DDTableView:self cellForRowAtIndexPath:indexPath];
    tableCell.indexPath = indexPath;
    
    if(top){
        [_reusableCells removeObject:tableCell];//remove object from current position
        [_reusableCells insertObject:tableCell atIndex:0];//add to top
    }
    else{
        [_reusableCells removeObject:tableCell];
        NSInteger bottomIndex = [_reusableCells count];
        [_reusableCells insertObject:tableCell atIndex:bottomIndex];//add to bottom
    }
    
//    [tableCell removeFromSuperview];
//    [_scrollView addSubview:tableCell];
    tableCell.frame = [self tableCellFrameWithIndexPath:tableCell.indexPath];
}


- (NSInteger)reusableCellCount
{
    CGFloat height = 50.0f;//default height
    
    if([_delegate respondsToSelector:@selector(DDTableView:heightForRowAtIndexPath:)]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        height = [_delegate DDTableView:self heightForRowAtIndexPath:indexPath];
    }
    
    NSInteger numberOfCells = CGRectGetHeight(self.frame)/height;
    NSInteger boundryCells = 2;
    NSInteger reusableCellCount = numberOfCells + boundryCells;
    
    return reusableCellCount;
}

- (NSInteger)totalCellCount
{
    NSInteger totalCellCount = 0;
    for(int i = 0; i < [_sections count]; i++)
        totalCellCount = totalCellCount + [[_sections objectAtIndex:i] intValue];
    
    return totalCellCount;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f, %f", scrollView.contentOffset.x, scrollView.contentOffset.y );
    
    CGFloat height = 100.0f;// need better way to get height
    
    BOOL addCellToBottom = scrollView.contentOffset.y > _scrollViewOffset.y + height;
    
    BOOL addCellToTop = scrollView.contentOffset.y < _scrollViewOffset.y;
    
    if(addCellToBottom){
    
        NSInteger bottomIndex = [_reusableCells count] - 1;
        DDTableViewCell *bottomCell = [_reusableCells objectAtIndex:bottomIndex];
        
        NSIndexPath *indexPath = [self indexPathBelow:bottomCell.indexPath];
        
        if(indexPath != nil){
            [self addCellWithIndexPath:indexPath atTop:NO];
            _scrollViewOffset.y = scrollView.contentOffset.y;
        }
    }
    else if(addCellToTop){
        //remove cell from bottom and add to top
    }
}

- (NSIndexPath *)indexPathBelow:(NSIndexPath *)indexPath
{
    NSIndexPath *indexPathBelow = nil;
    
    NSInteger currentSection = indexPath.section;
    
    NSInteger sectionCount = [_sections count];
    BOOL hasSectionsBelow = sectionCount > currentSection + 1;
    
    NSInteger totalRowsInSection = [[_sections objectAtIndex:currentSection] intValue];
    BOOL hasMoreRowsBelow = totalRowsInSection > indexPath.row + 1;
    
    if(hasMoreRowsBelow){
        NSInteger nextRow = indexPath.row + 1;
        indexPathBelow = [NSIndexPath indexPathForRow:nextRow inSection:currentSection];
    }
    else if(hasSectionsBelow){
        NSInteger nextSection = indexPath.section +1;
        indexPathBelow = [NSIndexPath indexPathForRow:0 inSection:nextSection];
    }
    
    return indexPathBelow;
}

#pragma mark - Frames

- (CGRect)tableCellFrameWithIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = 50.0f;
    if([_delegate respondsToSelector:@selector(DDTableView:heightForRowAtIndexPath:)]){
        height = [_delegate DDTableView:self heightForRowAtIndexPath:indexPath];
    }
    
    CGFloat x = 0.0f;
    CGFloat y = 0.0f + indexPath.row*height;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)scrollViewFrame
{
    
}

@end
