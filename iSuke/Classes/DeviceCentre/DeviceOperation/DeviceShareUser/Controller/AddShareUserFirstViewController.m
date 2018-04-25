//
//  AddShareUserFirstViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddShareUserFirstViewController.h"
#import "DeviceCentreModel.h"
#import "QueryUserApi.h"
#import "AddShareUser.h"

@interface AddShareUserFirstViewController ()<RTRequestDelegate>{
    Device *_device;
    
    QueryUserApi *queryUserApi;
    AddShareUser *addShareUser;
}

@property (weak, nonatomic) IBOutlet UIImageView *deviceIcon;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end

@implementation AddShareUserFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.deviceName.text = _device.device_alias;
    [_phoneTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}


- (IBAction)addAction:(id)sender {
    [SVProgressHUD showWithStatus:RTLocalizedString(@"请稍等...")];
    queryUserApi = [[QueryUserApi alloc] initWithShare_user_phone:_phoneTextField.text];
    queryUserApi.delegate = self;
    [queryUserApi start];
}



- (void)textFieldDidChanged:(UITextField *)textField{
    if (_phoneTextField.text.length > 0 ) {
        _addBtn.backgroundColor = kColorTheme;
        _addBtn.userInteractionEnabled = YES;
    }else{
        _addBtn.backgroundColor = kColorUnClickBtnBg;
        _addBtn.userInteractionEnabled = NO;
    }
}


#pragma mark RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request dataSuccess]) {
        addShareUser = [AddShareUser modelWithDictionary:request.responseObject[@"appUser"]];
        UIViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_DETAIL, SB_ADDSHARE_USER);
        [vc setValue:_device forKey:@"_device"];
        [vc setValue:addShareUser forKey:@"_addShareUser"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
}






@end
