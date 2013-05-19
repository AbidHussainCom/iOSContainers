//
//  DDTableViewController.m
//  DragDropTable
//
//  Created by Hari Kunwar on 5/18/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "DDTableViewController.h"
#import "DDTableView.h"
#import "DDTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DDTableViewController () <DDTableViewDelegate, DDTableViewDataSource>

@property (nonatomic, strong) DDTableView *tableView;

@end

@implementation DDTableViewController

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

    self.view.layer.borderWidth = 3.0f;
    self.view.layer.borderColor = [[UIColor yellowColor] CGColor];
    
    _tableView = [[DDTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - DDTableViewDataSource

- (NSInteger)DDTableView:(DDTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (DDTableViewCell *)DDTableView:(DDTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDTableViewCell *tableCell = [[DDTableViewCell alloc] init];
    
    tableCell.textLabel.text = [NSString stringWithFormat:@"section : %d row : %d", indexPath.section, indexPath.row];
    
    tableCell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    tableCell.layer.borderWidth = 3.0f;
    tableCell.layer.borderColor = [[UIColor redColor] CGColor];
    
    return tableCell;
}

#pragma mark - DDTableViewDelegate

- (CGFloat)DDTableView:(DDTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


@end
