//
//  FlipBoardView.m
//  FlipBoardView
//
//  Created by Hari Kunwar on 6/29/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "FlipBoardView.h"
#import "FBIndexPath.h"

@interface FlipBoardView () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) UIView *flipView;
@property (nonatomic, assign) UIView *leftFlipView;
@property (nonatomic, assign) UIView *rightFlipView;
@property (nonatomic, assign) UIView *upFlipView;
@property (nonatomic, assign) UIView *downFlipView;
@property (nonatomic, assign) CGPoint flipStartPoint;

@end

@implementation FlipBoardView

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _indexPath = [[FBIndexPath alloc] init];
    _indexPath.index = 0;
    _indexPath.page = 0;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(flipView:)];
    panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:panGestureRecognizer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    _flipView = [_delegate FlipBoardView:self flipViewAtFBIndexPath:_indexPath];
    _leftFlipView = [_delegate FlipBoardView:self leftFlipViewForFBIndexPath:_indexPath];
    _rightFlipView = [_delegate FlipBoardView:self rightFlipViewForFBIndexPath:_indexPath];
    _upFlipView = [_delegate FlipBoardView:self upFlipViewForFBIndexPath:_indexPath];
    _downFlipView = [_delegate FlipBoardView:self downFlipViewForFBIndexPath:_indexPath];
    
    _flipView.frame = self.bounds;
    _leftFlipView.frame = self.bounds;
    _rightFlipView.frame = self.bounds;
    _upFlipView.frame = self.bounds;
    _downFlipView.frame = self.bounds;
    
    _flipView.backgroundColor = [UIColor redColor];
    _downFlipView.backgroundColor = [UIColor redColor];
    
    [self addSubview:_upFlipView];
    [self addSubview:_leftFlipView];
    [self addSubview:_rightFlipView];
    [self addSubview:_downFlipView];
    [self addSubview:_flipView];
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
}

- (void)flipView:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *flipView = [gestureRecognizer view];
    
    UIGestureRecognizerState recognizerState = [gestureRecognizer state];
    
    if(recognizerState == UIGestureRecognizerStateBegan){
        _flipStartPoint = flipView.center;
    }
    
    CGPoint translatedPoint = [gestureRecognizer translationInView:self];
    translatedPoint = CGPointMake(_flipStartPoint.x + translatedPoint.x, _flipStartPoint.y + translatedPoint.y);
    
    
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self];
    
    FlipDirection flipDirection = [self flipDirectionWithVelocity:(CGPoint)velocity];
    
    UIView *toView = [self toViewWithFlipDirection:flipDirection];
    
    [self flipFromView:_flipView toView:toView direction:flipDirection distance:translatedPoint animated:NO];
    
    if (recognizerState == UIGestureRecognizerStateEnded){
        //animate
        //call didflip delegate method
//        [self flipFromView:_flipView toView:toView direction:flipDirection distance:translatedPoint animated:YES];
    }

}

- (void)flipFromView:(UIView *)fromView
              toView:(UIView *)toView
           direction:(FlipDirection)direction
            distance:(CGPoint)distance
            animated:(BOOL)animated
{
    if(animated){
        
    }
    else{
        CATransform3D _3Dt = CATransform3DRotate(self.layer.transform,1.04, 1.0, 0.0,0.0);
        self.layer.transform=_3Dt;
    }

}

- (UIView *)toViewWithFlipDirection:(FlipDirection)direction
{
    UIView *toView = nil;
    
    switch(direction){
        case FlipLeft:
            toView = _leftFlipView;
            break;
        case FlipRight:
            toView = _rightFlipView;
            break;
        case FlipUp:
            toView = _upFlipView;
            break;
        case FlipDown:
            toView = _downFlipView;
            break;
    }
    
    return toView;
}

- (FlipDirection)flipDirectionWithVelocity:(CGPoint)velocity
{
    FlipDirection flipDirection;
   
    BOOL verticalDirection = abs(velocity.y) > abs(velocity.x);
    
    if(verticalDirection){
        BOOL down = velocity.y > 0;
        flipDirection = down ? FlipDown : FlipUp;
    }
    else{
        BOOL right = velocity.x > 0;
        flipDirection = right ? FlipRight : FlipLeft;
    }
    
    return flipDirection;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

@end
