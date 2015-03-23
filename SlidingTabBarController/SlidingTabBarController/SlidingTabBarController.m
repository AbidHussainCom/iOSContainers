//
//  SlidingTabBarController.m
//  SlidingTabBarController
//
//  Created by Hari Kunwar on 3/23/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "SlidingTabBarController.h"

@interface SlidingTabBarController ()

@end

@implementation SlidingTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabBarHidden:(BOOL)tabBarHidden {
    
    _tabBarHidden = tabBarHidden;
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[UITabBar class]]) {
                if (tabBarHidden) {
                    CGRect frame = view.frame;
                    frame.origin.y = frame.origin.y + frame.size.height;
                    view.frame = frame;
                }
                else {
                    CGRect frame = view.frame;
                    frame.origin.y = frame.origin.y - frame.size.height;
                    view.frame = frame;
                }
            }
            else {
                if (tabBarHidden) {
                    CGRect frame = view.frame;
                    frame.size.height = frame.size.height + 44;
                    view.frame = frame;
                }
                else {
                    CGRect frame = view.frame;
                    frame.size.height = frame.size.height - 44;
                    view.frame = frame;
                }
            }
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
