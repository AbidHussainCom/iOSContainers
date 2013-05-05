//
//  CardViewController.m
//  CardContainer
//
//  Created by Hari Kunwar on 5/5/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "CardViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CardViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint gestureStartPoint;

@end

@implementation CardViewController

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
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCard:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pan card
- (void)panCard:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *cardView = [gestureRecognizer view];
    
    UIGestureRecognizerState recognizerState = [gestureRecognizer state];
    
    if(recognizerState == UIGestureRecognizerStateBegan){
        _gestureStartPoint = cardView.center;
    }
    
    CGPoint translatedPoint = [gestureRecognizer translationInView:self.view];
    translatedPoint = CGPointMake(_gestureStartPoint.x, _gestureStartPoint.y + translatedPoint.y);
    [cardView setCenter:translatedPoint];
    
    if (recognizerState == UIGestureRecognizerStateEnded){
        BOOL viewPannedUp = translatedPoint.y < _defaultCenter.y ? YES : NO;
        
        if(viewPannedUp){
            [self maximizeCard:self animated:YES];
        }
        else {
            [self restoreCard:self animated:YES];
        }
    }
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

#pragma mark - Maximize, Minimize and Restore(default size) cards

- (void)maximizeCard:(UIViewController *)card animated:(BOOL)animated
{
    if (card == nil)
        return;
    
    CGRect maxFrame = [self cardViewMaxFrame];
    if(animated){
        [self slideCardToFrame:maxFrame];
    }
    else {
        card.view.frame = maxFrame;
    }
}

- (void)minimizeCard:(UIViewController *)card animated:(BOOL)animated
{
    if (card == nil)
        return;
    
    CGRect minFrame = [self cardViewMaxFrame];
    
    if(animated){
        [self slideCardToFrame:minFrame];
    }
    else {
        card.view.frame = minFrame;
    }
}

- (void)restoreCard:(UIViewController *)card animated:(BOOL)animated
{
    if (card == nil)
        return;
        
    if(animated){
        [self slideCardToCenter:_defaultCenter];
    }
    else {
        card.view.center = _defaultCenter;
    }
}

#pragma mark - Slide Card

- (void)slideCardToFrame:(CGRect)frame
{
    void (^slideAnimation)(void) = ^(void){
        self.view.frame = frame;
    };
    
    void (^completion) (BOOL finished) = ^(BOOL finished){
        
    };
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:slideAnimation completion:completion];
}

- (void)slideCardToCenter:(CGPoint)center
{
    void (^slideAnimation)(void) = ^(void){
        self.view.center = center;
    };
    
    void (^completion) (BOOL finished) = ^(BOOL finished){
        
    };
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:slideAnimation completion:completion];
}


#pragma mark - Max, Min and Default card view frames

- (CGRect)cardViewMaxFrame
{
    return [UIScreen mainScreen].bounds;
}

- (CGRect)cardViewMinFrame
{
    CGFloat x = 0.0f;
    CGFloat y = CGRectGetMaxY(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)defaultFrame
{
    self.view.center = _defaultCenter;
    return self.view.frame;
}

@end
