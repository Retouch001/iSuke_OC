//
//  DeviceDetailViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceDetailViewController.h"

#import "EditJackNameView.h"

#import "DeviceDetailModel.h"


#import "DeviceDetailApi.h"
#import "OperatingSwitchApi.h"
#import "SetDeviceAliasApi.h"

@interface DeviceDetailViewController ()<RTRequestDelegate>{
    DeviceDetailApi *deviceDetailApi;
    OperatingSwitchApi *operatingSwitchApi;
    SetDeviceAliasApi *setDeviceAliasApi;
}

@property (weak, nonatomic) IBOutlet UIButton *mainSwitchBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstSwitchBtn;


@property (weak, nonatomic) IBOutlet UILabel *firstSwitchName;
@property (weak, nonatomic) IBOutlet UILabel *firstSwitchStatus;

@property (nonatomic, strong) EditJackNameView *editJackNameView;
@property (nonatomic, strong) DeviceDetailModel *deviceDetailModel;

@end

@implementation DeviceDetailViewController


#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",[_device modelDescription]);

        
    self.navigationController.navigationBarHidden = YES;
    deviceDetailApi = [[DeviceDetailApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id device_belong_type:_device.device_belong_type];
    deviceDetailApi.delegate = self;
    [deviceDetailApi start];
}




#pragma mark -IBAction--
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mainSwitchClick:(id)sender {
}

- (IBAction)firstSwitchClick:(id)sender {
    DeviceDetailInfo *deviceDetailInfo = _deviceDetailModel.deviceDetail[1];
    
    operatingSwitchApi = [[OperatingSwitchApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id device_sub_id:deviceDetailInfo.device_sub_id device_sub_num:deviceDetailInfo.device_sub_num device_sub_status:1 switch_type:deviceDetailInfo.switch_type device_sub_alias:deviceDetailInfo.device_sub_alias total_switch_exist:deviceDetailInfo.total_switch_exist device_belong_type:_device.device_belong_type];
    
    operatingSwitchApi.delegate = self;
    [operatingSwitchApi start];
}


- (IBAction)editFistSwitchNameAciton:(id)sender {
    setDeviceAliasApi = [[SetDeviceAliasApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_sub_id:_device.device_sub_id device_sub_alias:@"Hello" device_belong_type:_device.device_belong_type];
    setDeviceAliasApi.delegate = self;
    [setDeviceAliasApi start];
}




#pragma mark -RTRequestDelegate --
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request isKindOfClass:[deviceDetailApi class]]) {
        if ([request dataSuccess]) {
            _deviceDetailModel = [DeviceDetailModel modelWithDictionary:request.responseObject];
        }
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}



#pragma mark -Navigation--
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = segue.destinationViewController;
    [vc setValue:_device forKey:@"_device"];
    [vc setValue:_deviceDetailModel.deviceDetail.firstObject forKey:@"_deviceDetailInfo"];
}




#pragma mark -GetterSetter--
- (EditJackNameView *)editJackNameView{
    if (!_editJackNameView) {
        _editJackNameView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EditJackNameView class]) owner:nil options:nil] lastObject];
        _editJackNameView.layer.cornerRadius = 5;
        _editJackNameView.layer.masksToBounds = YES;
    }
    return _editJackNameView;
}


@end
