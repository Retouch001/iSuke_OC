//
//  TPAccessTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TPAccessTableViewController.h"
#import "TPAccessTableViewCell.h"

static NSString *const identifier = @"cell";

#define ItemHeight (self.view.height-5)/2

@interface TPAccessTableViewController ()

@end

@implementation TPAccessTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = UIColor.clearColor;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ItemHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPAccessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell freshCellWithIndexpath:indexPath];
    return cell;
}


@end
