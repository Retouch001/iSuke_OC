//
//  ModifyUserInfoViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ModifyUserInfoViewController.h"
#import "ModifyUserInfoApi.h"


@interface ModifyUserInfoViewController ()<RTRequestDelegate>{
    ModifyUserInfoApi *modifyUserInfoApi;
}

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBtn;


@end

@implementation ModifyUserInfoViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nickNameTextField.text = [MainUserManager getLocalMainUserInfo].nickname;
}

#pragma mark -IBAction--
- (IBAction)confirmBtnAction:(id)sender {
    modifyUserInfoApi = [[ModifyUserInfoApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id nickname:_nickNameTextField.text];
    modifyUserInfoApi.delegate = self;
    [modifyUserInfoApi start];
}
- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        MainUser *user = [MainUserManager getLocalMainUserInfo];
        user.nickname = _nickNameTextField.text;
        [MainUserManager updateLocalMainUserInfo:user];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}
@end
