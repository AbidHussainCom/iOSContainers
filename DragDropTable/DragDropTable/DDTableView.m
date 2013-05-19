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

@interface DDTableView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableArray *reusableCells;


@end

@implementation DDTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor grayColor];
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_sections == nil){
        NSInteger numberOfSections = [self numberOfSections];
        _sections = [self sectionsWithCapacity:numberOfSections];
        
        //Create screenful of content
        _reusableCells = [self reusableCells];
        
        [self layoutCells];
    }
    
    
    //create cells brute force
}

- (void)layoutCells
{
    CGFloat scrollViewHeight = 0.0f;
    for(DDTableViewCell *tableCell in _reusableCells){
        [_scrollView addSubview:tableCell];
        
        tableCell.frame = [self tableCellFrameWithIndexPath:tableCell.indexPath];
                
        scrollViewHeight = CGRectGetHeight(tableCell.frame) + scrollViewHeight;
    }
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), scrollViewHeight);
}


#pragma mark -

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


- (NSInteger)reusableCellCount
{
    CGFloat height = 50.0f;//default height
    
    if([_delegate respondsToSelector:@selector(DDTableView:heightForRowAtIndexPath:)]){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        height = [_delegate DDTableView:self heightForRowAtIndexPath:indexPath];
    }
    
    NSInteger numberOfCells = CGRectGetHeight(self.frame)/height;
    NSInteger boundryCells = 4;
    NSInteger reusableCellCount = numberOfCells + boundryCells;
    
    return reusableCellCount;
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
