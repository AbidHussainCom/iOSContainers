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
@property (nonatomic, readonly) NSInteger controlViewHeight;
@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *headerSubTitle;

+ (instancetype)tabBarControllerWithViewControllers:(NSArray *)viewControllers;
- (void)displaceTabBar:(CGFloat)displacement;

@end
