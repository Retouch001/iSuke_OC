//
//  ForgotPsdSecondViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ForgotPsdSecondViewController.h"
#import "RTVerifyCodeButton.h"
#import "ForgotPsdApi.h"
#import "VerifyCodeAPi.h"

#import "MainUserManager.h"
#import "RTAddinterceptor.h"


@interface ForgotPsdSecondViewController ()<RTRequestDelegate>{
    NSString *_phone;
    NSString *_country_code;
    
    VerifyCodeAPi *verfyCodeApi;
    ForgotPsdApi *forgotPsdApi;
}
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property (weak, nonatomic) IBOutlet RTVerifyCodeButton *verifyCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;

@end

@implementation ForgotPsdSecondViewController

#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_verifyCodeTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}


#pragma mark -IBAction--
- (IBAction)getVerifyCodeAction:(id)sender {
    [_verifyCodeBtn timeFailBeginFrom:60];
    verfyCodeApi = [[VerifyCodeAPi alloc] initWithPhone:_phone tag:RTGetVerifyCodeTypeFogotPsd country_code:_country_code];
    verfyCodeApi.delegate = self;
    [verfyCodeApi start];
}

- (IBAction)summitAction:(id)sender {
    forgotPsdApi = [[ForgotPsdApi alloc] initWithVerifyCode:_verifyCodeTextField.text password:_passwordTextField.text phone:_phone];
    forgotPsdApi.delegate = self;
    [forgotPsdApi start];
    [SVProgressHUD showWithStatus:@"正在重置..."];
}



#pragma mark - UITextFieldDidChanged---
- (void)textFieldDidChanged:(UITextField *)textField{
    if (_verifyCodeTextField.text.length == 4 && _passwordTextField.text.length > 0) {
        _summitBtn.backgroundColor = kColorTheme;
        _summitBtn.userInteractionEnabled = YES;
    }else{
        _summitBtn.backgroundColor = kColorUnClickBtnBg;
        _summitBtn.userInteractionEnabled = NO;
    }
}



#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request isKindOfClass:[ForgotPsdApi class]]) {
        if ([request dataSuccess]) {
            MainUser *mainUser = [MainUser modelWithDictionary:request.responseObject[@"appUser"]];
            [MainUserManager updateLocalMainUserInfo:mainUser];
            [RTAddinterceptor addInterceptorWithMainUser:mainUser];
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
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
}


@end
