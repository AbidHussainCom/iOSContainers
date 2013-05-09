//
//  LeftSplitViewController.m
//  SplitViewContainer
//
//  Created by Hari Kunwar on 5/6/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "LeftSplitViewController.h"
#import "ContentViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface LeftSplitViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LeftSplitViewController

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_delegate respondsToSelector:@selector(splitViewController:pushViewController:animated:)]){
        ContentViewController *viewController  = [self viewControllerWithIndexPath:indexPath];
        [_delegate splitViewController:self pushViewController:viewController animated:YES];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"ViewController %d", indexPath.row + 1];
    
    return cell;
}

#pragma mark - ContentViewController

- (ContentViewController *)viewControllerWithIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    
    ContentViewController *viewController = nil;
    
    switch(row){
        case 0:
            viewController = [[OneViewController alloc] init];
            break;
        case 1:
            viewController = [[TwoViewController alloc] init];
            break;
        case 2:
            viewController = [[ThreeViewController alloc] init];
            break;
        case 3:
            viewController = [[FourViewController alloc] init];
            break;
        default:
            break;
    }
    
    return viewController;
}

@end
