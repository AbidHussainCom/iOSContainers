//
//  ItemViewController.m
//  SlidingTabBarController
//
//  Created by Hari Kunwar on 3/23/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "ItemViewController.h"
#import "UIViewController+Extension.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleTabBar:(id)sender {
    [self toggleTabBarVisibility];
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
