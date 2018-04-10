//
//  CodeLoginSecondViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "CodeLoginSecondViewController.h"
#import "VerifyCodeAPi.h"
#import "LoginApi.h"
#import "MainUserManager.h"
#import "RTVerifyCodeButton.h"


@interface CodeLoginSecondViewController ()<RTRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet RTVerifyCodeButton *verifyCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation CodeLoginSecondViewController{
    NSString *_phone;
    NSString *_country_code;
    
    VerifyCodeAPi *verifyCodeApi;
    LoginApi *loginApi;
}

#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    [_verifyCodeTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark -IBAciton--
- (IBAction)getVerifyCodeAction:(id)sender {
    [_verifyCodeBtn timeFailBeginFrom:60];
    verifyCodeApi = [[VerifyCodeAPi alloc] initWithPhone:_phone tag:RTGetVerifyCodeTypeLogin country_code:_country_code];
    verifyCodeApi.delegate = self;
    [verifyCodeApi start];
}

- (IBAction)loginAciton:(id)sender {
    loginApi = [[LoginApi alloc] initWithCountryCode:_country_code phone:_phone password:@"" loginType:RTLoginTypeVerifyCode verifyCode:_verifyCodeTextField.text];
    loginApi.delegate = self;
    [loginApi start];
    [SVProgressHUD showWithStatus:@"正在登录..."];
}

#pragma mark - UITextFieldDidChanged---
- (void)textFieldDidChanged:(UITextField *)textField{
    if (_verifyCodeTextField.text.length == 4) {
        _loginBtn.backgroundColor = kColorTheme;
        _loginBtn.userInteractionEnabled = YES;
    }else{
        _loginBtn.backgroundColor = kColorUnClickBtnBg;
        _loginBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];

    if ([request isKindOfClass:[LoginApi class]]) {
        if ([request dataSuccess]) {
            MainUser *mainUser = [MainUser modelWithDictionary:request.responseObject[@"appUser"]];
            [MainUserManager updateLocalMainUserInfo:mainUser];
            
            UIViewController *mainVC = SB_VIEWCONTROLLER(SB_MAIN);
            kKeyWindow.rootViewController = mainVC;
        }else{
            [SVProgressHUD showErrorWithStatus:[request errorMessage]];
        }
    }else{
        if (![request dataSuccess]) {
            [SVProgressHUD showErrorWithStatus:[request errorMessage]];
        }
    }
    NSLog(@"请求成功----%@",request.responseObject);
}


- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];

    NSLog(@"请求失败----%@",request.error);
}


@end
