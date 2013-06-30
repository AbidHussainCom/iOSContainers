//
//  FlipBoardViewController.m
//  FlipBoard
//
//  Created by Hari Kunwar on 6/29/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "FlipBoardViewController.h"
#import "FlipBoardView.h"
#import "ArticleView.h"
#import "FBIndexPath.h"
#import "NSArray+Additions.h"

#define ARTICLE_COUNT 10

@interface FlipBoardViewController () <FlipBoardViewDelegate>

@property (nonatomic, strong) FlipBoardView *flipBoard;
@property (nonatomic, strong) NSMutableArray *articles;

@end

@implementation FlipBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    _articles = [self getArticles];
    
    _flipBoard = [[FlipBoardView alloc] initWithFrame:self.view.bounds];
    
    _flipBoard.delegate = self;
    
    [self.view addSubview:_flipBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSMutableArray *)getArticles
{
    NSMutableArray *articles = [[NSMutableArray alloc] init];
    for(int i = 0; i < ARTICLE_COUNT; i++){
        ArticleView *article = [[ArticleView alloc] init];
        article.titleLabel.text = [NSString stringWithFormat:@"ARTICLE : %d", i];
        [articles addObject:article];
    }
    
    return articles;
}

- (UIView *)articleViewAtIndex:(NSInteger)index
{
    return [_articles safeObjectAtIndex:index];    
}


#pragma mark - FlipBoardViewDelegate

- (UIView *)FlipBoardView:(FlipBoardView *)view flipViewAtFBIndexPath:(FBIndexPath *)indexPath
{
    NSInteger articleIndex = indexPath.index;
    return [self articleViewAtIndex:articleIndex];
}

- (UIView *)FlipBoardView:(FlipBoardView *)view leftFlipViewForFBIndexPath:(FBIndexPath *)indexPath
{
    NSInteger articleIndex = indexPath.index - 1;
    return [self articleViewAtIndex:articleIndex];
}

- (UIView *)FlipBoardView:(FlipBoardView *)view rightFlipViewForFBIndexPath:(FBIndexPath *)indexPath
{
    NSInteger articleIndex = indexPath.index + 1;
    return [self articleViewAtIndex:articleIndex];
}

- (UIView *)FlipBoardView:(FlipBoardView *)view upFlipViewForFBIndexPath:(FBIndexPath *)indexPath
{
    NSInteger articleIndex = indexPath.index - 1;
    return [self articleViewAtIndex:articleIndex];
}

- (UIView *)FlipBoardView:(FlipBoardView *)view downFlipViewForFBIndexPath:(FBIndexPath *)indexPath
{
    NSInteger articleIndex = indexPath.index + 1;
    return [self articleViewAtIndex:articleIndex];
}


@end
