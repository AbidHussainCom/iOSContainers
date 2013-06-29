//
//  FlipBoard.h
//  FlipBoard
//
//  Created by Hari Kunwar on 6/29/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipBoardDataSource <NSObject>

@end

@interface FlipBoard : UIView

- (id)initWithCentralView:(UIView *)centralView
                 leftView:(UIView *)leftView
                rightView:(UIView *)rightView
                   upView:(UIView *)upView
                 downView:(UIView *)downView;

- (void)updateCentralView:(UIView *)centralView
                 leftView:(UIView *)leftView
                rightView:(UIView *)rightView
                   upView:(UIView *)upView
                 downView:(UIView *)downView;

@end
