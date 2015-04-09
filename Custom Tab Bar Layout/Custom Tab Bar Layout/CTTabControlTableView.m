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
        
        [self addObserver:self forKeyPath:@"tabBarController" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}


//Observing tabBarController.controlViewHeight to be set.
//Using it to set tableHeaderView
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"tabBarController"]) {
        [self.tabBarController addObserver:self forKeyPath:@"controlViewHeight" options:NSKeyValueObservingOptionNew context:nil];
    }
    else if ([keyPath isEqualToString:@"controlViewHeight"]) {
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.tabBarController.controlViewHeight)];
    }
    else if ([keyPath isEqualToString:@"contentOffset"]) {
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.tabBarController.controlViewHeight)];
        
        CGFloat offset = self.contentOffset.y;
        CGFloat displacement = offset - _startingOffset;
        [self.tabBarController displaceTabBar:-displacement];

        _startingOffset = offset;
    }
}


@end
