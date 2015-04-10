//
//  CTTabItem.h
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/9/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CTTabItem : UIControl

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) NSUInteger tagNumber;

+ (instancetype)tabItemWithTitle:(NSString *)title image:(UIImage *)image tag:(NSUInteger)tag;

@end
