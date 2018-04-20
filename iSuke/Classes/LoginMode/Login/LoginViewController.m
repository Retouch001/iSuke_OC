//
//  LoginViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "LoginViewController.h"
#import "SelectCountryTableViewController.h"
#import "LoginApi.h"
#import "MainUserManager.h"

@interface LoginViewController ()<RTRequestDelegate>

@property (weak, nonatomic) IBOutlet UILabel *countryName;
@property (weak, nonatomic) IBOutlet UILabel *countryCode;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController{
    LoginApi *loginApi;
}

#pragma mark -LifeCycel--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_phoneTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}



#pragma mark -IBAction--
- (IBAction)selectCountryAction:(id)sender {
    SelectCountryTableViewController *selectCountryVC = [[SelectCountryTableViewController alloc] init];
    @weakify(self);
    selectCountryVC.block = ^(NSString *countryName, NSString *countryCode) {
        @strongify(self);
        self.countryCode.text = countryCode;
        self.countryName.text = countryName;
    };
    RTRootNavigationController *rtNav = [[RTRootNavigationController alloc] initWithRootViewController:selectCountryVC];
    [self presentViewController:rtNav animated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
    loginApi = [[LoginApi alloc] initWithCountryCode:_countryCode.text phone:_phoneTextField.text password:_passwordTextField.text loginType:RTLoginTypePassword verifyCode:@""];
    loginApi.delegate = self;
    [loginApi start];
    [SVProgressHUD showWithStatus:@"正在登录..."];
}


#pragma mark - UITextFieldDidChanged---
- (void)textFieldDidChanged:(UITextField *)textField{
    if (_phoneTextField.text.length > 0 && _passwordTextField.text.length > 0) {
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
    
    if ([request dataSuccess]) {
        MainUser *mainUser = [MainUser modelWithDictionary:request.responseObject[@"appUser"]];
        [MainUserManager updateLocalMainUserInfo:mainUser];
        
        UIViewController *mainVC = SB_VIEWCONTROLLER(SB_MAIN);
        kKeyWindow.rootViewController = mainVC;
    }else{
        [SVProgressHUD showErrorWithStatus:[request errorMessage]];
    }
}


- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
}



@end
