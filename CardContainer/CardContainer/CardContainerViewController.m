//
//  CardContainerViewController.m
//  CardContainer
//
//  Created by Hari Kunwar on 5/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "CardContainerViewController.h"
#import "CardViewController.h"

#define CONTAINER_TOP_CARD_Y 100.0f
#define CARD_HOLDING_HEAD   50.0f

@interface CardContainerViewController () <CardViewControllerDelegate>

@property (nonatomic, readwrite, copy) NSArray *viewControllers;
@property (nonatomic, readwrite) UIViewController *selectedController;
@property (nonatomic, readwrite) NSUInteger selectedIndex;

@end

@implementation CardContainerViewController

- (id)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        _viewControllers = viewControllers;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addCardsFromArray:(NSArray *)_viewControllers];
    [self stackCards];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private card methods
- (void)addCardsFromArray:(NSArray *)cards
{
    if(cards == nil)
        return;
    
    for(CardViewController *card in cards){
        [self addChildViewController:card];
        [self.view addSubview:card.view];
        [card didMoveToParentViewController:self];
        card.delegate = self;
    }
}

- (void)stackCards
{
    NSUInteger index = 0;
    for(UIViewController *card in self.childViewControllers){
        [self pushInCardAtIndex:index animated:NO];
        index++;
    }
}


#pragma mark - Public card methods

- (void)pushInCardAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    //layout card view on container based on index
    CardViewController *card = [self.childViewControllers objectAtIndex:index];
        
    if(animated){
        void (^slideAnimation)(void) = ^(void){
            
        };
        
        void (^completion) (BOOL finished) = ^(BOOL finished){
        
        };

        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:slideAnimation completion:completion];
    }
    else {
        card.view.frame = [self cardFrameWithIndex:index];
        card.defaultCenter = card.view.center;
    }
    
}


#pragma mark - Card Frames
- (CGRect)cardFrameWithIndex:(NSUInteger)index
{
    CGFloat x = 0.0f;
    CGFloat y = CONTAINER_TOP_CARD_Y + index * CARD_HOLDING_HEAD;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    return CGRectMake(x, y, width, height);
}

#pragma mark - CardViewControllerDelegate

- (void)cardViewController:(id)sender shouldMinimizeTopCardsAnimated:(BOOL)animated
{
    if (sender == nil)
        return;
    
    NSUInteger index = [self.childViewControllers indexOfObject:sender];
    NSUInteger count = [self.childViewControllers count];
    
    for(int i = index + 1 ; i < count; i++){
        CardViewController *card = [self.childViewControllers objectAtIndex:i];
        [card minimizeCardAnimated:animated];
    }
}

- (void)cardViewController:(id)sender shouldRestoreTopCardsAnimated:(BOOL)animated;
{
    if (sender == nil)
        return;
    
    NSUInteger index = [self.childViewControllers indexOfObject:sender];
    NSUInteger count = [self.childViewControllers count];
    
    for(int i = index + 1 ; i < count; i++){
        CardViewController *card = [self.childViewControllers objectAtIndex:i];
        [card restoreCardAnimated:YES];
    }

}


@end
