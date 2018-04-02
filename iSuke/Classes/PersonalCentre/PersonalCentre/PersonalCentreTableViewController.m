//
//  PersonalCentreTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PersonalCentreTableViewController.h"

@interface PersonalCentreTableViewController ()

@end

@implementation PersonalCentreTableViewController

#pragma mark ---LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.extendedLayoutIncludesOpaqueBars = YES;
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.tableView.separatorColor = self.tableView.backgroundColor;
    self.navigationController.navigationBarHidden = YES;

}


- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated{
}




#pragma mark  ---UITableViewDelegate---
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






@end
