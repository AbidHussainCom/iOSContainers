//
//  SplitViewDelegate.h
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/8/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SplitViewDelegate <NSObject>

- (void)splitViewController:(UIViewController *)splitViewController pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end