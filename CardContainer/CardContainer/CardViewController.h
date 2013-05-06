//
//  CardViewController.h
//  CardContainer
//
//  Created by Hari Kunwar on 5/5/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardViewControllerDelegate <NSObject>

- (void)cardViewController:(id)sender shouldMinimizeTopCardsAnimated:(BOOL)animated;
- (void)cardViewController:(id)sender shouldRestoreTopCardsAnimated:(BOOL)animated;

@end

@interface CardViewController : UIViewController

@property (nonatomic, assign) id<CardViewControllerDelegate> delegate;
@property (nonatomic, assign) CGPoint defaultCenter;
@property (nonatomic, readonly) BOOL maximized;
@property (nonatomic, readonly) BOOL minimized;


- (void)minimizeCardAnimated:(BOOL)animated;
- (void)restoreCardAnimated:(BOOL)animated;

@end
