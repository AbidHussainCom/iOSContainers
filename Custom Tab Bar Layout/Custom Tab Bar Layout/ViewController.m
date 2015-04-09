//
//  ViewController.m
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/8/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "ViewController.h"
#import "CTTabBarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIViewController *viewController1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController1"];
    viewController1.view.backgroundColor = [UIColor redColor];
    viewController1.title = @"tab1";

    UIViewController *viewController2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController2"];
    viewController2.view.backgroundColor = [UIColor blueColor];
    viewController2.title = @"tab2";

    UIViewController *viewController3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController3"];
    viewController3.view.backgroundColor = [UIColor greenColor];
    viewController3.title = @"tab3";

    UIViewController *viewController4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController4"];
    viewController4.view.backgroundColor = [UIColor yellowColor];
    viewController4.title = @"tab4";

    
    CTTabBarController *tabBarController = [CTTabBarController tabBarControllerWithViewControllers:@[viewController1, viewController2, viewController3, viewController4]];
    
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    [tabBarController willMoveToParentViewController:self];
    
    tabBarController.view.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
