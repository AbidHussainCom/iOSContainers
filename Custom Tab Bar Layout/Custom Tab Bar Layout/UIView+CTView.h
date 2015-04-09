//
//  UIView+CTView.h
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/9/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CTView)

@property (nonatomic, readonly) CGFloat top;
@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, readonly) CGFloat left;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

- (void)showLayoutBorders;
- (void)showLayoutBordersWithColor:(UIColor *)color;

@end
