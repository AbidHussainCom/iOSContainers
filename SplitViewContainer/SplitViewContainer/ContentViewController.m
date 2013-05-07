//
//  ContentViewController.m
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "ContentViewController.h"
#import <QuartzCore/QuartzCore.h>

#define EDGE_OFFSET 80.0f

@interface ContentViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint gestureStartPoint;
@property (nonatomic, assign) BOOL viewOnEdge;

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

#pragma mark - Pan

- (void)panContentView:(id)sender
{
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)sender;
    
    UIView *contentView = [gesture view];
    
    UIGestureRecognizerState state = [gesture state];
        
    if(state == UIGestureRecognizerStateBegan){
        _gestureStartPoint = contentView.center;
    }
    
    CGPoint translatedPoint = [sender translationInView:self.view];
    translatedPoint = CGPointMake(_gestureStartPoint.x + translatedPoint.x, _gestureStartPoint.y);
    contentView.center = translatedPoint;
    
    CGPoint velocity = [gesture velocityInView:self.view];
    
    if(state == UIGestureRecognizerStateEnded){
        BOOL slideRight = velocity.x > 0 ? YES : NO;
        
        if(slideRight){
            [self slideRight];
        }
        else{
            [self slideLeft];
        }
        _viewOnEdge = !_viewOnEdge;
    }
    
}

- (void)slideRight
{
    CGRect frame =  _viewOnEdge ? [self centerFrame] : [self rightFrame];
    [self animateToFrame:frame];
}

- (void)slideLeft
{
    CGRect frame =  _viewOnEdge ?  [self centerFrame] : [self leftFrame];
    [self animateToFrame:frame];
}

- (void)animateToFrame:(CGRect)frame
{
    void (^animation) (void) = ^(void){
        self.view.frame = frame;
    };
    void (^completion) (BOOL finished) = ^ (BOOL finished) {};
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:animation completion:completion];
}


#pragma mark - Frames
- (CGRect)leftFrame
{
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat x =  EDGE_OFFSET - width;
    CGFloat y = 0.0f;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)rightFrame
{
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
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
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}


@end
