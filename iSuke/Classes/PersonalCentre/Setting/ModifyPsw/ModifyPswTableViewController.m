//
//  ModifyPswTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ModifyPswTableViewController.h"
#import "ModifyPswApi.h"

@interface ModifyPswTableViewController ()<RTRequestDelegate>{
    ModifyPswApi *modifyPswApi;
}
@property (weak, nonatomic) IBOutlet UITextField *usedPswTextField;
@property (weak, nonatomic) IBOutlet UITextField *freshPswTextField;
@property (weak, nonatomic) IBOutlet UITextField *freshPswAgainTextField;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation ModifyPswTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    [_usedPswTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [_freshPswTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [_freshPswAgainTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark -IBAciton--
- (IBAction)commitAction:(id)sender {
    modifyPswApi = [[ModifyPswApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id oldPsw:_usedPswTextField.text newPsw:_freshPswAgainTextField.text];
    modifyPswApi.delegate = self;
    [modifyPswApi start];
}

#pragma mark -UITextFieldDelegate--
- (void)textFieldDidChanged:(UITextField *)textField{
    if (_usedPswTextField.text.length > 5 && _freshPswTextField.text.length > 5 && _freshPswAgainTextField.text.length > 5 && [_freshPswTextField.text isEqualToString:_freshPswAgainTextField.text]) {
        _commitBtn.backgroundColor = kColorTheme;
        _commitBtn.enabled = YES;
    }else{
        _commitBtn.backgroundColor = kColorUnClickBtnBg;
        _commitBtn.enabled = YES;
    }
}


#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        [SVProgressHUD showSuccessWithStatus:RTLocalizedString(@"修改成功")];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}

@end
