//
//  SplitViewContainerController.h
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentViewController;
@class LeftSplitViewController;
@class RightSplitViewController;

@interface SplitViewContainerController : UIViewController

@property (nonatomic, strong) ContentViewController *contentViewController;
@property (nonatomic, strong) LeftSplitViewController *leftSplitViewController;
@property (nonatomic, strong) RightSplitViewController *rightSplitViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController
              leftSplitViewController:(UIViewController *)leftSplitViewController
             rightSplitViewController:(UIViewController *)rightSplitViewController;

- (void)pushContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated;

@end
