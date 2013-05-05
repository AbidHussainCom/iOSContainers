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

@interface CardContainerViewController ()

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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private card methods
- (void)addCardsFromArray:(NSArray *)cards
{
    if(cards == nil)
        return;
    
    for(UIViewController<CardProtocol> *card in cards){
        [self addChildViewController:card];
        [self.view addSubview:card.view];
        [card didMoveToParentViewController:self];
    }
}

- (void)stackCards
{
    NSUInteger index = 0;
    for(UIViewController<CardProtocol> *card in self.childViewControllers){
        [self pushInCardAtIndex:index animated:NO];
        index++;
    }
}


#pragma mark - Public card methods
//- (void)pullOutCard:(UIViewController<CardProtocol> *)card animated:(BOOL)animated
//{
//
//}
//
//- (void)pullOutCardAtIndex:(NSUInteger)index animated:(BOOL)animated
//{
//
//}
//
//- (void)pushInCard:(UIViewController<CardProtocol> *)card animated:(BOOL)animated
//{
//    if (card == nil)
//        return;
//    
//    NSUInteger cardIndex = [self.childViewControllers indexOfObject:card];
//    
//    if(cardIndex != NSNotFound)
//        [self pushInCardAtIndex:cardIndex animated:(BOOL)animated];
//}

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



@end
