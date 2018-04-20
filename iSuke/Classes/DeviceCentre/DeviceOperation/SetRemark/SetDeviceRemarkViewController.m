//
//  SetDeviceRemarkViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SetDeviceRemarkViewController.h"
#import "SetDeviceAliasApi.h"

@interface SetDeviceRemarkViewController ()<RTRequestDelegate>{
    SetDeviceAliasApi *_setDeviceAliasApi;
}

@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
@end

@implementation SetDeviceRemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _remarkTextField.text = _device.device_alias;
    [_remarkTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}


- (IBAction)leftBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)rightBtnClick:(id)sender {
    if ([_remarkTextField.text isEqualToString:_device.device_alias]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [SVProgressHUD showWithStatus:RTLocalizedString(@"请稍等...")];
        _setDeviceAliasApi = [[SetDeviceAliasApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_sub_id:_deviceDetailInfo.device_sub_id device_sub_alias:_remarkTextField.text device_belong_type:_device.device_belong_type device_id:_device.device_id];
        _setDeviceAliasApi.delegate = self;
        [_setDeviceAliasApi start];
    }
}



#pragma mark -UITextFieldEditingDidChanged--
- (void)textFieldDidChanged:(UITextField *)textField{
    
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request dataSuccess]) {
        _device.device_alias = _remarkTextField.text;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}
@end
