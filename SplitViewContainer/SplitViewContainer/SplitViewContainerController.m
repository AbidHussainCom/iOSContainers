//
//  SplitViewContainerController.m
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "SplitViewContainerController.h"
#import "ContentViewController.h"

@interface SplitViewContainerController () <ContentViewDelegate>

@property (nonatomic, strong) UIView *titleBar;

@end

@implementation SplitViewContainerController

- (id)initWithContentViewController:(ContentViewController *)contentViewController
              leftSplitViewController:(UIViewController *)leftSplitViewController
             rightSplitViewController:(UIViewController *)rightSplitViewController
{
    self = [super init];
    
    if(self) {
        _contentViewController = contentViewController;
        _leftSplitViewController = leftSplitViewController;
        _rightSplitViewController = rightSplitViewController;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    if(_leftSplitViewController != nil){
        [self addChildViewController:_leftSplitViewController];
        [self.view addSubview:_leftSplitViewController.view];
        _leftSplitViewController.view.frame = [self leftSplitViewFrame];
    }
    
    if(_rightSplitViewController != nil){
        [self addChildViewController:_rightSplitViewController];
        [self.view addSubview:_rightSplitViewController.view];
        _rightSplitViewController.view.frame = [self rightSplitViewFrame];
    }
    
    if(_contentViewController != nil){
        [self addChildViewController:_contentViewController];
        [self.view addSubview:_contentViewController.view];
        _contentViewController.view.frame = self.view.bounds;
        _contentViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Frames

- (CGRect)leftSplitViewFrame
{
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat width = CGRectGetWidth(self.view.bounds) - EDGE_OFFSET;
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)rightSplitViewFrame
{
    CGFloat x = EDGE_OFFSET;
    CGFloat y = 0.0f;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    return CGRectMake(x, y, width, height);
}

#pragma mark - Push
- (void)pushContentViewController:(ContentViewController *)contentViewController animated:(BOOL)animated
{
    if(animated){
        //slide in contentViewController 
    }
    else{
        _contentViewController = contentViewController;
    }
}

#pragma mark - ContentViewDelegate;

-(void)willSlideFromPosition:(position)fromPosition toPosition:(position)toPosition
{
    BOOL slidingToRightEdge = (fromPosition == Center && toPosition == RightEdge);
    BOOL slidingToLeftEdge = (fromPosition == Center && toPosition == LeftEdge);

    
    if(slidingToRightEdge){
        _rightSplitViewController.view.hidden = YES;
        _leftSplitViewController.view.hidden = NO;
    }
    else if(slidingToLeftEdge){
        _leftSplitViewController.view.hidden = YES;
        _rightSplitViewController.view.hidden = NO;
    }
}

-(void)didSlideToPosition:(position)position
{
    
}


@end
