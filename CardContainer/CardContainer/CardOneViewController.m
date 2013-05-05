//
//  CardOneViewController.m
//  CardContainer
//
//  Created by Hari Kunwar on 5/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "CardOneViewController.h"

@interface CardOneViewController ()

@end

@implementation CardOneViewController

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
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIContainerViewControllerCallbacks

- (void)willMoveToParentViewController:(UIViewController *)parent
{

}

- (void)didMoveToParentViewController:(UIViewController *)parent
{

}

@end
