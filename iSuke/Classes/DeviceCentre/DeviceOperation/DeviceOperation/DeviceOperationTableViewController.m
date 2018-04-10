//
//  DeviceOperationTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceOperationTableViewController.h"
#import "SetDeviceRemarkViewController.h"
#import "DeviceDetailModel.h"
#import "DeviceCentreModel.h"

@interface DeviceOperationTableViewController ()

@property (nonatomic, strong) Device *device;
@property (nonatomic, strong) DeviceDetailInfo *deviceDetailInfo;

@end

@implementation DeviceOperationTableViewController
#pragma mark -LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = self.tableView.backgroundColor;
}



#pragma mark -UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        UIViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_PERSONAL_CENTRE, SB_FEEDBACK);
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark -Navagation---
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"setDeviceAlias"]) {
        UINavigationController *setMarkNav = segue.destinationViewController;
        
        SetDeviceRemarkViewController *setMarkVC = setMarkNav.viewControllers.firstObject;
        [setMarkVC setValue:_device forKey:@"_device"];
        [setMarkVC setValue:_deviceDetailInfo forKey:@"_deviceDetailInfo"];
        
        setMarkVC.block = ^(NSString *string){
            NSLog(@"回传成功-------------%@",string);
        };
    }
}

@end
