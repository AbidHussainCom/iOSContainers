//
//  CardContainerViewController.h
//  CardContainer
//
//  Created by Hari Kunwar on 5/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardProtocol.h"

@interface CardContainerViewController : UIViewController

@property (nonatomic, readonly, copy) NSArray *viewControllers;
@property (nonatomic, readonly) UIViewController *selectedController;
@property (nonatomic, readonly) NSUInteger selectedIndex;

- (id)initWithViewControllers:(NSArray *)viewControllers;

@end
