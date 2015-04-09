//
//  CTTabControlTableView.h
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/9/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  CTTabBarController;

@interface CTTabControlTableView : UITableView

@property (nonatomic, weak) CTTabBarController *tabBarController;

@end
