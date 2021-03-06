//
//  ShareDeviceOperationTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/25.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ShareDeviceOperationTableViewController.h"
#import "SetDeviceRemarkViewController.h"
#import "DeviceDetailModel.h"
#import "DeviceCentreModel.h"
#import "DeleteDeviceApi.h"

@interface ShareDeviceOperationTableViewController ()<RTRequestDelegate>{
    DeleteDeviceApi *deleteDeviceApi;
}
@property (nonatomic, strong) Device *device;
@property (nonatomic, strong) DeviceDetailInfo *deviceDetailInfo;

@property (weak, nonatomic) IBOutlet UILabel *deviceAliasLabel;
@property (weak, nonatomic) IBOutlet UILabel *ShareUserLabel;

@end

@implementation ShareDeviceOperationTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshUI];
}

- (void)freshUI{
    _deviceAliasLabel.text = _device.device_alias;
    _ShareUserLabel.text = _device.device_user_name;
}


#pragma mark -UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3) {
        UIViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_PERSONAL_CENTRE, SB_FEEDBACK);
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 4){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:RTLocalizedString(@"确定移除设备吗？") preferredStyle:UIAlertControllerStyleAlert];
        @weakify(self);
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            NSString *deviceId_userId = [NSString stringWithFormat:@"%ld@%ld",(long)self->_device.device_id,(long)self->_device.device_user_id];
            self->deleteDeviceApi = [[DeleteDeviceApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id deviceId_userId:deviceId_userId];
            self->deleteDeviceApi.delegate = self;
            [self->deleteDeviceApi start];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        [kNotificationCenter postNotificationName:RTDeviceCenterDidChangeNotification object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
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
    }else{
        id vc = segue.destinationViewController;
        [vc setValue:_device forKey:@"_device"];
    }
}


@end
