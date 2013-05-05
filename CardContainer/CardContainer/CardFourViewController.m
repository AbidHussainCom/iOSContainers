//
//  CardFourViewController.m
//  CardContainer
//
//  Created by Hari Kunwar on 5/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "CardFourViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CardFourViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint gestureStartPoint;

@end

@implementation CardFourViewController

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
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
