//
//  SettingTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = self.tableView.backgroundColor;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        UIViewController *mainVC = SB_VIEWCONTROLLER(SB_LOGIN_MODE);
        kKeyWindow.rootViewController = mainVC;
    }
}



@end
