//
//  FlipBoardView.h
//  FlipBoardView
//
//  Created by Hari Kunwar on 6/29/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBIndexPath;

typedef enum FlipDirection{
    FlipLeft,
    FlipRight,
    FlipUp,
    FlipDown
}FlipDirection;

@class FlipBoardView;


@protocol FlipBoardViewDelegate <NSObject>

@required
- (UIView *)FlipBoardView:(FlipBoardView *)view flipViewAtFBIndexPath:(FBIndexPath *)indexPath;
- (UIView *)FlipBoardView:(FlipBoardView *)view leftFlipViewForFBIndexPath:(FBIndexPath *)indexPath;
- (UIView *)FlipBoardView:(FlipBoardView *)view rightFlipViewForFBIndexPath:(FBIndexPath *)indexPath;
- (UIView *)FlipBoardView:(FlipBoardView *)view upFlipViewForFBIndexPath:(FBIndexPath *)indexPath;
- (UIView *)FlipBoardView:(FlipBoardView *)view downFlipViewForFBIndexPath:(FBIndexPath *)indexPath;

@optional
- (NSInteger)FlipBoardView:(FlipBoardView *)view numberOfFlipViewsInBoard:(NSInteger)views;
- (void)FlipBoardView:(FlipBoardView *)view willFlipDirection:(FlipDirection)direction;
- (void)FlipBoardView:(FlipBoardView *)view didFlipDirection:(FlipDirection)direction;

@end


@interface FlipBoardView : UIView

@property (nonatomic, assign) id<FlipBoardViewDelegate> delegate;
@property (nonatomic, strong) FBIndexPath *indexPath;

@end

