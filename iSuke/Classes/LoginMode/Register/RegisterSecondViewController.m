//
//  RegisterSecondViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RegisterSecondViewController.h"
#import "RTVerifyCodeButton.h"
#import "RegisterApi.h"
#import "VerifyCodeAPi.h"

#import "MainUserManager.h"

@interface RegisterSecondViewController ()<RTRequestDelegate>{
    NSString *_phone;
    NSString *_country_code;
    
    RegisterApi *registerApi;
    VerifyCodeAPi *verifyCodeApi;
}

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet RTVerifyCodeButton *getVerifyCodeBtn;


@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *doneClickAction;

@end

@implementation RegisterSecondViewController

#pragma mark  -LifeCycle----
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_verifyCodeTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}



#pragma mark  --IBAction---
- (IBAction)doneRegiserAction:(id)sender {
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    registerApi = [[RegisterApi alloc] initWithCountry_code:_country_code phone:_phone psd:[_passwordTextField.text md5String] verifycode:_verifyCodeTextField.text];
    registerApi.delegate = self;
    [registerApi start];
}

- (IBAction)getVerifyCodeAction:(id)sender {
    [_getVerifyCodeBtn timeFailBeginFrom:60];
    verifyCodeApi = [[VerifyCodeAPi alloc] initWithPhone:_phone tag:RTGetVerifyCodeTypeRegister country_code:_country_code];
    verifyCodeApi.delegate = self;
    [verifyCodeApi start];
}



#pragma mark - UITextFieldDidChanged---
- (void)textFieldDidChanged:(UITextField *)textField{
    if (_verifyCodeTextField.text.length == 4 && _passwordTextField.text.length > 0) {
        _doneClickAction.backgroundColor = kColorTheme;
        _doneClickAction.userInteractionEnabled = YES;
    }else{
        _doneClickAction.backgroundColor = kColorUnClickBtnBg;
        _doneClickAction.userInteractionEnabled = NO;
    }
}



#pragma mark - RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request isKindOfClass:[RegisterApi class]]) {
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
}


- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request isKindOfClass:[RegisterApi class]]) {
    }else{
    }
}




@end
