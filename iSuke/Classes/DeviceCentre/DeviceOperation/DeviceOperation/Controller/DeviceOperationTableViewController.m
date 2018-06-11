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
#import "CurrentDevice.h"

#import "DeleteDeviceApi.h"
#import "UpdateDeviceVApi.h"
#import "SearchDeviceVApi.h"

#import "RTUdpSocketManager.h"
#import "RTAlertContrller.h"

@interface DeviceOperationTableViewController ()<RTRequestDelegate,RTUdpSocketDelegate>{
    DeleteDeviceApi *deleteDeviceApi;
    SearchDeviceVApi *searchDeviceVApi;
    UpdateDeviceVApi *updateDeviceVApi;
}
@property (nonatomic, strong) Device *device;
@property (nonatomic, strong) DeviceDetailInfo *deviceDetailInfo;
@property (weak, nonatomic) IBOutlet UILabel *deviceAliasLabel;
@end

@implementation DeviceOperationTableViewController
#pragma mark -LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshUI];
}


#pragma mark -PrivateMethod---
- (void)freshUI{
    _deviceAliasLabel.text = _device.device_alias;
}

- (void)updateDeviceVersionByServer{
    UpdateDeviceVApi *updateApi = [[UpdateDeviceVApi alloc] initWithDevice_mac:_device.device_mac software_version:_device.software_version];
    updateApi.delegate = self;
    [updateApi start];
}

- (void)searchDeviceVersionByServer{
    SearchDeviceVApi *searchApi = [[SearchDeviceVApi alloc] initWithDevice_mac:_device.device_mac];
    searchApi.delegate = self;
    [searchApi start];
}

- (void)searchDeviceVersionBySocket{
    NSData *data = [[RTParseGenerateDataManager shareInstance] searchConmmandDataWithMac:_device.device_mac];
    [[RTUdpSocketManager shareInstance] sendDataWithData:data];
    [RTUdpSocketManager shareInstance].delegate = self;
}

- (void)updateDeviceVersionBySocket{
    
}

- (void)deleteDevice{
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


#pragma mark -UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            UIViewController *vc = SB_VIEWCONTROLLER(SB_DEVICE_CONFIG);
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }else if (indexPath.row == 3){
            [self searchDeviceVersionByServer];
            //[self searchDeviceVersionBySocket];
        }
    }else if (indexPath.section == 3){
        UIViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_PERSONAL_CENTRE, SB_FEEDBACK);
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self deleteDevice];
    }
}


#pragma mark -RTUdpSocketDelegate--
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    if (tag == 100) {
    }
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
    BOOL update = [[RTParseGenerateDataManager shareInstance] updateExistWithData:data softV:_device.software_version hardV:_device.firmware_version];
    NSString *string = update?RTLocalizedString(@"有可用更新!!!"):RTLocalizedString(@"已是最新版!");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:RTLocalizedString(@"提示") message:string preferredStyle:UIAlertControllerStyleAlert];
    if (update) {
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:nil]];
        @weakify(self);
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"下载并更新") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
//            NSData *data = [[RTParseGenerateDataManager shareInstance] updateConmmandDataWithIP:@"" version:@""];
//            [[RTUdpSocketManager shareInstance] sendDataWithData:data];
//            [RTUdpSocketManager shareInstance].delegate = self;
        }]];
    }else{
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"知道了") style:UIAlertActionStyleCancel handler:nil]];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
    //[[RTUdpSocketManager shareInstance] closeUdp];
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request isKindOfClass:[SearchDeviceVApi class]]) {
        if ([request dataSuccess]) {
            CurrentDevice *device = [CurrentDevice modelWithDictionary:request.responseObject];
            BOOL canUpdate = [device.firmware_version isEqualToString:_device.firmware_version] && ([self converStringToInt:_device.software_version] > [self converStringToInt:device.software_version]);
            NSString *string = canUpdate?RTLocalizedString(@"有可用更新!!!"):RTLocalizedString(@"已是最新版!");
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:RTLocalizedString(@"提示") message:string preferredStyle:UIAlertControllerStyleAlert];
            if (canUpdate) {
                [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:nil]];
                @weakify(self);
                [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"下载并更新") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    @strongify(self);
                    [self updateDeviceVersionByServer];
                }]];
            }else{
                [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"知道了") style:UIAlertActionStyleCancel handler:nil]];
            }
            [self presentViewController:alertVC animated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else if ([request isKindOfClass:[UpdateDeviceVApi class]]){
        if ([request dataSuccess]) {
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else{
        if ([request dataSuccess]) {
            [kNotificationCenter postNotificationName:RTDeviceCenterDidChangeNotification object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
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

- (int)converStringToInt:(NSString *)string{
    NSArray *softArray = [string componentsSeparatedByString:@"."];
    NSMutableString *vString = [NSMutableString string];
    for (int i = 0; i<softArray.count; i++) {
        NSString *string = softArray[i];
        string = [NSString stringWithFormat:@"0%@",string];
        [vString appendString:string];
    }
    return [vString intValue];
}
@end
