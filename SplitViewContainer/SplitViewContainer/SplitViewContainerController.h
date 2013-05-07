//
//  SplitViewContainerController.h
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplitViewContainerController : UIViewController

@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, strong) UIViewController *leftSplitViewController;
@property (nonatomic, strong) UIViewController *rightSplitViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController
              leftSplitViewController:(UIViewController *)leftSplitViewController
             rightSplitViewController:(UIViewController *)rightSplitViewController;

- (void)pushContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated;

@end
