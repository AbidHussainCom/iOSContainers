//
//  UIViewController+Extension.m
//  SlidingTabBarController
//
//  Created by Hari Kunwar on 3/23/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "SlidingTabBarController.h"

@implementation UIViewController (Extension)

- (void)toggleTabBarVisibility {
    if ([self.parentViewController isMemberOfClass:[SlidingTabBarController class]]) {
        SlidingTabBarController *tabBarController = (SlidingTabBarController *) self.parentViewController;
        tabBarController.tabBarHidden = !tabBarController.tabBarHidden;
    }
}


@end
