//
//  CTTabControlTableView.m
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/9/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "CTTabControlTableView.h"
#import "CTTabBarController.h"
#import "UIView+CTView.h"

@interface CTTabControlTableView () <UITableViewDelegate>

@end

@implementation CTTabControlTableView {
    CGFloat _startingOffset;
    CGFloat _gestureStart;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _startingOffset = 0;
//        [self.panGestureRecognizer addTarget:self action:@selector(panning:)];
        
        [self addObserver:self forKeyPath:@"tabBarController" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    }
    return self;
}

- (void)awakeFromNib {
}


//Observing tabBarController.controlViewHeight to be set.
//Using it to set tableHeaderView
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"tabBarController"]) {
        [self.tabBarController addObserver:self forKeyPath:@"controlViewHeight" options:NSKeyValueObservingOptionNew context:nil];
        NSLog(@"%@", change);
    }
    
    if ([keyPath isEqualToString:@"controlViewHeight"]) {
        NSLog(@"%@", change);
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.tabBarController.controlViewHeight)];
    }
    
}

- (void)panning:(UIPanGestureRecognizer *)gestureRecognizer {
    
    //Using content offset to calculate displacement
    CGFloat offset = self.contentOffset.y;
    
    //Don't displace tab bar when table view bounces.
    BOOL notTopBounce = offset > 0;
    BOOL notBottomBounce = offset <= (self.contentSize.height - self.bounds.size.height);
    if (notTopBounce && notBottomBounce) {
        CGFloat displacement = offset - _startingOffset;
        [self displaceTabBar:displacement];
        _startingOffset = offset;
    }
    
    //Using state information to decide on correct animation(hide/show)
    UIGestureRecognizerState recognizerState = [gestureRecognizer state];
    
    if(recognizerState == UIGestureRecognizerStateBegan){
    }
    else if (recognizerState == UIGestureRecognizerStateEnded){
        
        CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self];
        BOOL hide = velocity.y < 0;
        [self.tabBarController hideTabBar:hide animated:YES];
    }
    
}


#pragma mark -

- (void)displaceTabBar:(CGFloat)displacement {
    
    [self.tabBarController displaceTabBar:displacement];
}




@end
