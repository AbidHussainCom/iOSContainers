//
//  SplitViewContainerController.m
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "SplitViewContainerController.h"

@interface SplitViewContainerController ()

@property (nonatomic, strong) UIView *titleBar;

@end

@implementation SplitViewContainerController

- (id)initWithContentViewController:(UIViewController *)contentViewController
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
    
    self.view.backgroundColor = [UIColor blueColor];
    
    if(_leftSplitViewController != nil){
        [self addChildViewController:_leftSplitViewController];
        [self.view addSubview:_leftSplitViewController.view];
        _leftSplitViewController.view.frame = self.view.bounds;
    }
    
    if(_rightSplitViewController != nil){
        [self addChildViewController:_rightSplitViewController];
        [self.view addSubview:_rightSplitViewController.view];
        _rightSplitViewController.view.frame = self.view.bounds;
    }
    
    if(_contentViewController != nil){
        [self addChildViewController:_contentViewController];
        [self.view addSubview:_contentViewController.view];
        _contentViewController.view.frame = self.view.bounds;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Push
- (void)pushContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated
{
    if(animated){
        //slide in contentViewController 
    }
    else{
        _contentViewController = contentViewController;
    }
}



@end
