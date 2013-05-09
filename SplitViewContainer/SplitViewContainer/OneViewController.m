//
//  OneViewController.m
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

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
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"OneViewController";
    label.textColor = [UIColor blackColor];
    label.frame = [self labelFrame];
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - frame

- (CGRect)labelFrame
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = 100.0f;
    CGFloat x = 0.0f;
    CGFloat y = CGRectGetHeight(self.view.bounds)/2 - height/2;
    
    return CGRectMake(x, y, width, height);
}


@end
