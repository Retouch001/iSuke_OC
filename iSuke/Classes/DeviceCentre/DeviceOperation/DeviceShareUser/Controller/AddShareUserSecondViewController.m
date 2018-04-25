//
//  AddShareUserSecondViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddShareUserSecondViewController.h"
#import "AddShareUserApi.h"
#import "DeviceCentreModel.h"
#import "AddShareUser.h"

@interface AddShareUserSecondViewController ()<RTRequestDelegate>{
    Device *_device;
    AddShareUser *_addShareUser;
    
    AddShareUserApi *addShareUserApi;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *deviceIcon;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;

@property (weak, nonatomic) IBOutlet UIImageView *shareUserIcon;
@property (weak, nonatomic) IBOutlet UILabel *shareUserName;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation AddShareUserSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deviceName.text = _device.device_alias;
    self.shareUserName.text = kStringIsEmpty(_addShareUser.nickname)?_addShareUser.phone:_addShareUser.nickname;
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    [self.shareUserIcon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",config.baseUrl,RT_ICON_BASE,_addShareUser.avatar]] placeholder:[UIImage imageNamed:RTPORTRAIT]];
}


- (IBAction)comfirmAciton:(id)sender {
    [SVProgressHUD showWithStatus:RTLocalizedString(@"请稍后...")];
    addShareUserApi = [[AddShareUserApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id share_user_id:_addShareUser.app_user_id device_id:_device.device_id];
    addShareUserApi.delegate = self;
    [addShareUserApi start];
}


#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request dataSuccess]) {
        [kNotificationCenter postNotificationName:RTShareUserDidChangeNotification object:nil];
        [self.navigationController popToViewController:self.navigationController.viewControllers[3] animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end
