//
//  CTTabBarController.h
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/8/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTabBarController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;

+ (instancetype)tabBarControllerWithViewControllers:(NSArray *)viewControllers;

- (void)displaceTabBar:(CGFloat)displacement;
- (void)hideTabBar:(BOOL)hide animated:(BOOL)animated;

@end
