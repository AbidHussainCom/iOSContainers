//
//  AppDelegate.h
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/8/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) CTTabBarController *tabBarController;

+ (instancetype)sharedInstance;

@end

