//
//  ViewController3.m
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/9/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "ViewController3.h"
#import "AppDelegate.h"
#import "CTTabControlTableView.h"

@interface ViewController3 ()

@end

@implementation ViewController3 {
    __weak IBOutlet CTTabControlTableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.tabBarController = (CTTabBarController *)[AppDelegate sharedInstance].tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    return cell;
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
