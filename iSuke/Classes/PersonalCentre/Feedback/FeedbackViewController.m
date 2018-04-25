//
//  FeedbackViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackApi.h"
#import "UITextView+ZWPlaceHolder.h"
#import "UITextView+ZWLimitCounter.h"

@interface FeedbackViewController ()<RTRequestDelegate>{
    FeedbackApi *feedbackApi;
}
@property (weak, nonatomic) IBOutlet UITextView *feedbackContent;
@property (weak, nonatomic) IBOutlet UITextField *feedbackContact;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedbackContent.zw_placeHolder = RTLocalizedString(@"假如您在使用APP或操作硬件的过程中，遇到有不便之处，或不存在您想要的功能，请详细描述，我们将记录您宝贵的意见或建议，并将改进在新的版本中。");
    self.feedbackContent.zw_limitCount = 200;
    self.feedbackContent.zw_placeHolderColor = [UIColor colorWithHexString:@"C7C7CD"];
}

- (IBAction)submitAction:(id)sender {
    if (_feedbackContent.text.length > 0) {
        [SVProgressHUD show];
        feedbackApi = [[FeedbackApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id feedback_contact:_feedbackContact.text feedback_content:_feedbackContent.text device_id:-1];
        feedbackApi.delegate = self;
        [feedbackApi start];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:RTLocalizedString(@"反馈内容不能为空") preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"确定") style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request dataSuccess]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
}

@end
