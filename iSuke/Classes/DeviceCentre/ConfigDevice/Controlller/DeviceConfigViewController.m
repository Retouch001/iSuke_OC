//
//  DeviceConfigViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/18.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceConfigViewController.h"
#import "DeviceConfigSecondViewController.h"

#import "EditWiFiInfoView.h"
#import "NotConnectWiFiView.h"
#import "DeviceCofigProgressView.h"
#import "ConfigDeviceFailView.h"

#import <SystemConfiguration/CaptiveNetwork.h>
#import "RTUdpSocketManager.h"

#import "QueryDeviceStatusApi.h"
#import "AddDeviceApi.h"


@interface DeviceConfigViewController ()<RTUdpSocketDelegate,RTRequestDelegate>{
    NSString *wifiName;
    NSString *psd;
    
    NSString *mac;
    
    QueryDeviceStatusApi *queryDeviceStatusApi;
    AddDeviceApi *addDeviceApi;
}

@property (nonatomic, strong) EditWiFiInfoView *editWiFiInfoView;
@property (nonatomic, strong) NotConnectWiFiView *notConnectWiFiView;
@property (nonatomic, strong) ConfigDeviceFailView *configDeviceFailView;

@property (weak, nonatomic) IBOutlet UIImageView *indicator;
@property (weak, nonatomic) IBOutlet DeviceCofigProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@property (nonatomic, strong) YYTimer *timer;
@end

@implementation DeviceConfigViewController
#pragma mark -LifeCycel--
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)nextAction:(id)sender {
    if ([self fetchSSIDInfo][@"SSID"] ) {
        @weakify(self);
        [self.editWiFiInfoView showWithCancel:nil ok:^(NSString *wifiName, NSString *wifiPsd) {
            @strongify(self);
            
            self ->wifiName = wifiName;
            self ->psd = wifiPsd;
            DeviceConfigSecondViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_CONFIG, SB_DEVICE_CONFIG_SECOND);
            vc.block = ^{
                [self inConfigMode];
                [[RTUdpSocketManager shareInstance] sendDataWithWiFiName:self->wifiName psd:self->psd];
                [RTUdpSocketManager shareInstance].delegate = self;
            };
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        @weakify(self);
        [self.notConnectWiFiView showWithCancel:nil ok:^{
            @strongify(self);
            [self toWIFI];
        }];
    }

}

- (void)timerAction:(id)sender{
    self.progressView.progress += 0.0001;
    self.percentLabel.text = [NSString stringWithFormat:@"%.f%%",self.progressView.progress*100];
    
    if (self.progressView.progress >= 1) {
        [self.configDeviceFailView showWithCancel:nil ok:nil];
        [self endConfigMode];
    }
}


#pragma mark -RTUdpSocketDelegate--
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    if (tag == 100) {
    }
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    [self.configDeviceFailView showWithCancel:nil ok:nil];
    [self endConfigMode];
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
//    NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
//    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    
    Byte *bytes = (Byte *)[data bytes];
    if (bytes[5] == 0x01) {
        NSData *macData = [data subdataWithRange:NSMakeRange(6, 6)];
        NSString *macString = [self convertDataToHexStr:macData];
        mac = macString;
        queryDeviceStatusApi = [[QueryDeviceStatusApi alloc] initWithMac:macString];
        queryDeviceStatusApi.delegate = self;
        [queryDeviceStatusApi start];
    }else{
        [self.configDeviceFailView showWithCancel:nil ok:nil];
        [self endConfigMode];
    }
    [[RTUdpSocketManager shareInstance] closeUdp];
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request isKindOfClass:[QueryDeviceStatusApi class]]) {
        if ([request dataSuccess]) {
            BOOL deviceStatus = [request.responseObject[@"device_online_status"] boolValue];
            if (deviceStatus) {
                addDeviceApi  = [[AddDeviceApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_mac:mac];
                addDeviceApi.delegate = self;
                [addDeviceApi start];
            }else{
                [self.configDeviceFailView showWithCancel:nil ok:nil];
                [self endConfigMode];
            }
        }else{
            [self.configDeviceFailView showWithCancel:nil ok:nil];
            [self endConfigMode];
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else{
        if ([request dataSuccess]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:RTLocalizedString(@"设备添加成功")];
        }else{
            [self.configDeviceFailView showWithCancel:nil ok:nil];
            [self endConfigMode];
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


#pragma mark -GetterSetter--
- (EditWiFiInfoView *)editWiFiInfoView{
    if (!_editWiFiInfoView) {
        _editWiFiInfoView = [EditWiFiInfoView createFromXib];
    }
    return _editWiFiInfoView;
}

- (NotConnectWiFiView *)notConnectWiFiView{
    if (!_notConnectWiFiView) {
        _notConnectWiFiView = [NotConnectWiFiView createFromXib];
    }
    return _notConnectWiFiView;
}

- (ConfigDeviceFailView *)configDeviceFailView{
    if (!_configDeviceFailView) {
        _configDeviceFailView = [ConfigDeviceFailView createFromXib];
    }
    return _configDeviceFailView;
}


#pragma mark -PrivateMethod--
- (void)inConfigMode{
    self.timer = [[YYTimer alloc] initWithFireTime:0 interval:0.01 target:self selector:@selector(timerAction:) repeats:YES];
    [self.nextBtn setTitle:RTLocalizedString(@"配置中...") forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:UIColor.clearColor];
    self.nextBtn.enabled = NO;
    self.progressView.hidden = NO;
    self.percentLabel.hidden = NO;
}

- (void)endConfigMode{
    [self.timer invalidate];
    [self.nextBtn setTitle:RTLocalizedString(@"下一步") forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:kColorTheme];
    self.nextBtn.enabled = YES;
    self.progressView.hidden = YES;
    self.percentLabel.hidden = YES;
}


- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange,BOOL *stop) {
        unsigned char *dataBytes = (unsigned char *)bytes;
        for (NSInteger i =0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) &0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

- (NSDictionary *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}

-(void)toWIFI {
    NSURL *url1 = [NSURL URLWithString:@"App-Prefs:root=INTERNET_TETHERING"];
    // iOS10也可以使用url2访问，不过使用url1更好一些，可具体根据业务需求自行选择
    //NSURL *url2 = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (@available(iOS 11.0, *)) {
        [[UIApplication sharedApplication] openURL:url1 options:@{} completionHandler:nil];
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:url1]){
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url1 options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url1];
            }
        }
    }
}
@end
