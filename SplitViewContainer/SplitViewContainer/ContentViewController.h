//
//  ContentViewController.h
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EDGE_OFFSET 80.0f

typedef enum{
    SlideLeft,
    SlideRight,
}SlideDirection;

typedef enum{
    LeftEdge,
    RightEdge,
    Center
}position;

@protocol ContentViewDelegate <NSObject>

-(void)willSlideFromPosition:(position)fromPosition toPosition:(position)toPosition;
-(void)didSlideToPosition:(position)position;

@end

@interface ContentViewController : UIViewController

@property (nonatomic, assign) id<ContentViewDelegate> delegate;
@property (nonatomic, assign) CGFloat viewEdgeOffset;

@end
