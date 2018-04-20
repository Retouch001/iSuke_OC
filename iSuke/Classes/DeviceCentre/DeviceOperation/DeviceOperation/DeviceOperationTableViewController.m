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

#import "DeleteDeviceApi.h"

@interface DeviceOperationTableViewController ()<RTRequestDelegate>{
    DeleteDeviceApi *deleteDeviceApi;
}


@property (nonatomic, strong) Device *device;
@property (nonatomic, strong) DeviceDetailInfo *deviceDetailInfo;

@property (weak, nonatomic) IBOutlet UILabel *deviceAliasLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceVersionLabel;


@end

@implementation DeviceOperationTableViewController
#pragma mark -LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = self.tableView.backgroundColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshUI];
}

- (void)freshUI{
    _deviceAliasLabel.text = _device.device_alias;
}



#pragma mark -UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        UIViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_PERSONAL_CENTRE, SB_FEEDBACK);
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 4){
        
        NSString *deviceId_userId = [NSString stringWithFormat:@"%ld@%ld",(long)_device.device_id,(long)_device.device_user_id];
        deleteDeviceApi = [[DeleteDeviceApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id deviceId_userId:deviceId_userId];
        deleteDeviceApi.delegate = self;
        [deleteDeviceApi start];
    }else if (indexPath.section == 2&&indexPath.row == 2){
        UIViewController *vc = SB_VIEWCONTROLLER(SB_DEVICE_CONFIG);
        
        [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
    }
}




#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
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
    }else{
        id vc = segue.destinationViewController;
        [vc setValue:_device forKey:@"_device"];
    }
}

@end
