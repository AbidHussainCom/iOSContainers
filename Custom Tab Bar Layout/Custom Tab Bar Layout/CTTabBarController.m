//
//  CTTabBarController.m
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/8/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "CTTabBarController.h"

@interface CTTabBarController ()

@end

@implementation CTTabBarController {
    __weak IBOutlet UIView *_tabBar;
    __weak IBOutlet UIView *_containerView;
    __weak IBOutlet UIView *_headerView;
}

+ (instancetype)tabBarControllerWithViewControllers:(NSArray *)viewControllers {
    CTTabBarController *viewController = [[UIStoryboard storyboardWithName:@"CTTabBar" bundle:nil] instantiateViewControllerWithIdentifier:@"CTTabBarController"];
    viewController.viewControllers = viewControllers;
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (UIViewController *viewController in self.viewControllers) {
        [self addChildViewController:viewController];
        [self.view addSubview:viewController.view];
        
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.layer.borderColor = [[UIColor yellowColor] CGColor];
        tabButton.layer.borderWidth = 1.0f;
        [tabButton setTitle:viewController.title forState:UIControlStateNormal];
        [_tabBar addSubview:tabButton];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    for (UIViewController *viewController in self.viewControllers) {
        viewController.view.frame = _containerView.bounds;
    }
    
    CGFloat x = 0, y = 0, width = CGRectGetWidth(_tabBar.bounds)/self.viewControllers.count, height = CGRectGetHeight(_tabBar.bounds);
    for (UIView *subView in _tabBar.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            subView.frame = CGRectMake(x, y, width, height);
            x = x + CGRectGetWidth(subView.bounds);
        }
    }
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