//
//  RightSplitViewController.h
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewDelegate.h"

@interface RightSplitViewController : UIViewController

@property (nonatomic, assign) id<SplitViewDelegate>delegate;
@property (nonatomic, assign) CGFloat viewEdgeOffset;

@end
