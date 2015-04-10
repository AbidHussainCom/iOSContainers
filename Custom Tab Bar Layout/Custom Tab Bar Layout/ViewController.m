//
//  ViewController.m
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/8/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "ViewController.h"
#import "CTTabBarController.h"
#import "CTTabItem.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIViewController *viewController1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController1"];
    viewController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"view1" image:[UIImage imageNamed:@""] tag:0];
    
    viewController1.title = @"tab1";

    UIViewController *viewController2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController2"];
    viewController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"view2" image:[UIImage imageNamed:@""] tag:0];

    viewController2.title = @"tab2";

    UIViewController *viewController3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController3"];
    viewController3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"view3" image:[UIImage imageNamed:@""] tag:0];
    viewController3.title = @"tab3";

    UIViewController *viewController4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewController4"];
    viewController4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"view4" image:[UIImage imageNamed:@""] tag:5];
    viewController4.title = @"tab4";
    
    CTTabBarController *tabBarController = [CTTabBarController tabBarControllerWithViewControllers:@[viewController1, viewController2, viewController3, viewController4]];
    tabBarController.headerImage = [UIImage imageNamed:@"Profile"];
    tabBarController.headerTitle = @"Wayne Ronney";
    tabBarController.headerSubTitle = @"Soccer";
    
    [AppDelegate sharedInstance].tabBarController = tabBarController;

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
