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
    Device *_device;
    DeviceDetailApi *deviceDetailApi;
    OperatingSwitchApi *operatingSwitchApi;
    SetDeviceAliasApi *setDeviceAliasApi;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationBarConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *mainSwitchBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstSwitchBtn;

@property (weak, nonatomic) IBOutlet UILabel *firstSwitchName;
@property (weak, nonatomic) IBOutlet UILabel *firstSwitchStatus;
@property (nonatomic, assign) BOOL switchStatus;

@property (nonatomic, strong) EditJackNameView *editJackNameView;
@property (nonatomic, strong) DeviceDetailModel *deviceDetailModel;

@end

@implementation DeviceDetailViewController
#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.topViewConstraint.constant = HEADER_HEIGHT;
    self.navigationController.navigationBarHidden = YES;
    if (IPHONE_X) {
        self.navigationBarConstraint.constant = 88;
    }else{
        self.navigationBarConstraint.constant = 64;
    }
    deviceDetailApi = [[DeviceDetailApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id device_belong_type:_device.device_belong_type];
    deviceDetailApi.delegate = self;
    [deviceDetailApi start];
    [SVProgressHUD show];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshUI];
}


#pragma mark -IBAction--
- (IBAction)leftBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)rightBtnClick:(id)sender {
    UIViewController *vc;
    if (_device.device_belong_type == RTDeviceBelongTypeOwn) {
        vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_DETAIL, SB_DEVICE_OPERATE);
    }else{
        vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_DETAIL, SB_SHARE_DEVICE_OPERATE);
    }
    [vc setValue:_device forKey:@"_device"];
    [vc setValue:_deviceDetailModel.deviceDetail.firstObject forKey:@"_deviceDetailInfo"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)mainSwitchClick:(id)sender {
    [SVProgressHUD showWithStatus:RTLocalizedString(@"正在执行...")];
    
    DeviceDetailInfo *deviceDetailInfo = _deviceDetailModel.deviceDetail[0];
    operatingSwitchApi = [[OperatingSwitchApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id device_sub_id:deviceDetailInfo.device_sub_id device_sub_num:deviceDetailInfo.device_sub_num device_sub_status:!_switchStatus switch_type:deviceDetailInfo.switch_type device_sub_alias:deviceDetailInfo.device_sub_alias total_switch_exist:deviceDetailInfo.total_switch_exist device_belong_type:_device.device_belong_type];
    
    operatingSwitchApi.delegate = self;
    [operatingSwitchApi start];
}

- (IBAction)firstSwitchClick:(id)sender {
    [SVProgressHUD showWithStatus:RTLocalizedString(@"正在执行...")];

    DeviceDetailInfo *deviceDetailInfo = _deviceDetailModel.deviceDetail[1];
    operatingSwitchApi = [[OperatingSwitchApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id device_sub_id:deviceDetailInfo.device_sub_id device_sub_num:deviceDetailInfo.device_sub_num device_sub_status:!_switchStatus switch_type:deviceDetailInfo.switch_type device_sub_alias:deviceDetailInfo.device_sub_alias total_switch_exist:deviceDetailInfo.total_switch_exist device_belong_type:_device.device_belong_type];
    
    operatingSwitchApi.delegate = self;
    [operatingSwitchApi start];
}


- (IBAction)editFistSwitchNameAciton:(id)sender {
    self.editJackNameView = [EditJackNameView createFromXib];
    [self.editJackNameView showWithCancel:nil ok:^(NSString *number) {
        [SVProgressHUD showWithStatus:RTLocalizedString(@"正在执行...")];
        DeviceDetailInfo *firstJack = self.deviceDetailModel.deviceDetail[1];
        self ->setDeviceAliasApi = [[SetDeviceAliasApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_sub_id:firstJack.device_sub_id device_sub_alias:number device_belong_type:self->_device.device_belong_type device_id:self->_device.device_id];
        self->setDeviceAliasApi.delegate = self;
        [self->setDeviceAliasApi start];
    }];
}


#pragma mark -PrivateMethod--
- (void)freshUI{
    self.titleLabel.text = kStringIsEmpty(_device.device_alias)?_device.device_name:_device.device_alias;
    DeviceDetailInfo *mainJack = self.deviceDetailModel.deviceDetail.firstObject;
    if (mainJack.device_sub_status == RTDeviceSubStatusOn) {
        [self.mainSwitchBtn setImage:[UIImage imageNamed:@"ic_turnonturnoff1"] forState:UIControlStateNormal];
    }else{
        [self.mainSwitchBtn setImage:[UIImage imageNamed:@"ic_turnonturnoff2"] forState:UIControlStateNormal];
    }
    
    DeviceDetailInfo *firstJack = self.deviceDetailModel.deviceDetail[1];
    if (firstJack.device_sub_status == RTDeviceSubStatusOn) {
        [self.firstSwitchBtn setImage:[UIImage imageNamed:@"ic_3random02"] forState:UIControlStateNormal];
    }else{
        [self.firstSwitchBtn setImage:[UIImage imageNamed:@"ic_3normal_random"] forState:UIControlStateNormal];
    }
    self.firstSwitchName.text = kStringIsEmpty(firstJack.device_sub_alias)?_device.device_name:firstJack.device_sub_alias;
    self.firstSwitchStatus.text = firstJack.device_sub_status?RTLocalizedString(@"已开启"):RTLocalizedString(@"已关闭");
    self.switchStatus = firstJack.device_sub_status;
}


#pragma mark -RTRequestDelegate --
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request dataSuccess]) {
        _deviceDetailModel = [DeviceDetailModel modelWithDictionary:request.responseObject];
        [self freshUI];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }

}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
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
