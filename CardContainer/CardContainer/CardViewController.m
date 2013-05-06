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
@property (nonatomic, readwrite, assign) BOOL maximized;
@property (nonatomic, readwrite, assign) BOOL minimized;

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
    
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
    
    if (recognizerState == UIGestureRecognizerStateEnded){
        BOOL viewPannedUp = velocity.y < 0 ? YES : NO;
        
        if(viewPannedUp){
            [self maximizeCardAnimated:YES];
            _maximized = YES;
            [self minimizeTopCardsAnimated:YES];
        }
        else {
            [self restoreCardAnimated:YES];

            if(_maximized)
                [self restoreTopCardsAnimated:YES];
            
            _maximized = NO;
        }
    }
}

#pragma mark - Minimize/Restore top cards
- (void)minimizeTopCardsAnimated:(BOOL)animated
{
    if([_delegate respondsToSelector:@selector(cardViewController: shouldMinimizeTopCardsAnimated:)]){
        [_delegate cardViewController:self shouldMinimizeTopCardsAnimated:animated];
    }
}

- (void)restoreTopCardsAnimated:(BOOL)animated
{
    if([_delegate respondsToSelector:@selector(cardViewController: shouldRestoreTopCardsAnimated:)]){
        [_delegate cardViewController:self shouldRestoreTopCardsAnimated:YES];
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

- (void)maximizeCardAnimated:(BOOL)animated
{
    CGRect maxFrame = [self cardViewMaxFrame];
    if(animated){
        [self slideCardToFrame:maxFrame];
    }
    else {
        self.view.frame = maxFrame;
    }
}

- (void)minimizeCardAnimated:(BOOL)animated
{

    CGRect minFrame = [self cardViewMinFrame];
    
    if(animated){
        [self slideCardToFrame:minFrame];
    }
    else {
        self.view.frame = minFrame;
    }
}

- (void)restoreCardAnimated:(BOOL)animated
{
    if(animated){
        [self slideCardToCenter:_defaultCenter];
    }
    else {
        self.view.center = _defaultCenter;
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
