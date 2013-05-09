//
//  ContentViewController.m
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "ContentViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ContentViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint gestureStartPoint;

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panContentView:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Pan/Slide

- (void)panContentView:(id)sender
{
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)sender;
    
    UIView *contentView = [gesture view];
    
    UIGestureRecognizerState state = [gesture state];
    
    CGPoint velocity = [gesture velocityInView:self.view];

    if(state == UIGestureRecognizerStateBegan){
        _gestureStartPoint = contentView.center;
    }
    
    CGPoint translatedPoint = [sender translationInView:self.view];
    translatedPoint = CGPointMake(_gestureStartPoint.x + translatedPoint.x, _gestureStartPoint.y);

    //Hide/Show Left/Right SplitViewControllers
    BOOL viewMovingFromCenter = !_viewOnEdge;
    if(viewMovingFromCenter){
        BOOL panningRight = translatedPoint.x > _gestureStartPoint.x ? YES : NO;
        
        if(panningRight){
            if([_delegate respondsToSelector:@selector(willSlideFromPosition:toPosition:)]){
                [_delegate willSlideFromPosition:Center toPosition:RightEdge];
            }
        }
        else{
            if([_delegate respondsToSelector:@selector(willSlideFromPosition:toPosition:)]){
                [_delegate willSlideFromPosition:Center toPosition:LeftEdge];
            }
        }
    }

    //Block view from panning outside bounds
    BOOL panningInsideBounds = [self panningInsideBoundsWithTranslatedPoint:(CGPoint)translatedPoint];
    if(panningInsideBounds)
        contentView.center = translatedPoint;
    
    if(state == UIGestureRecognizerStateEnded){
        BOOL slideRight = velocity.x > 0 ? YES : NO;
        
        CGRect frame;
        //Animate view to final position
        if(_viewOnEdge){
            frame = [self centerFrame];
        }
        else if(slideRight){
            frame = [self rightFrame];
        }
        else{
            frame = [self leftFrame];
        }
        
        [self slideToFrame:frame animated:YES];
        _viewOnEdge = !_viewOnEdge;
    }
    
}

#pragma mark - Slide
- (void)slideViewToCenterAnimated:(BOOL)animated
{
    CGRect frame = [self centerFrame];
    [self slideToFrame:frame animated:animated];
    _viewOnEdge = NO;
}



- (void)slideToFrame:(CGRect)frame animated:(BOOL)animated
{
    if(animated){
        void (^animation) (void) = ^(void){
            self.view.frame = frame;
        };
        void (^completion) (BOOL finished) = ^ (BOOL finished) {};
        
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:animation completion:completion];
    }
    else{
        self.view.frame = frame;
    }
}

- (BOOL)panningInsideBoundsWithTranslatedPoint:(CGPoint)translatedPoint
{
    BOOL panningInsideBounds = YES;
    
    CGFloat maxX =  CGRectGetMidX([self rightFrame]);
    CGFloat minX = CGRectGetMidX([self leftFrame]);
    
    NSLog(@"%f", translatedPoint.x);
    
    if(translatedPoint.x > maxX || translatedPoint.x < minX){
        panningInsideBounds = NO;
    }
    
    return panningInsideBounds;
}


#pragma mark - Frames
- (CGRect)leftFrame
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat x =  EDGE_OFFSET - width;
    CGFloat y = 0.0f;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)rightFrame
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat x = width - EDGE_OFFSET;
    CGFloat y = 0.0f;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)centerFrame
{
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    return CGRectMake(x, y, width, height);
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL gestureRecognizerShouldBegin = YES;
    
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
    UIView *view = [gestureRecognizer view];
    
    if(_viewOnEdge){
        BOOL contentViewOnRightEdge = view.center.x > _gestureStartPoint.x;
        BOOL slidingRight = velocity.x > 0;
        
        BOOL contentViewOnLeftEdge = view.center.x < _gestureStartPoint.x;
        BOOL slidingLeft = velocity.x < 0;
        
        if(contentViewOnRightEdge && slidingRight)
            gestureRecognizerShouldBegin = NO;
        
        if(contentViewOnLeftEdge && slidingLeft)
            gestureRecognizerShouldBegin = NO;
    }
    
    return gestureRecognizerShouldBegin;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}


@end
