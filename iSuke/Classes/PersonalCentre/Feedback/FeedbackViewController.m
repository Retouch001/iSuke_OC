//
//  FeedbackViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackApi.h"

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
}

- (IBAction)submitAction:(id)sender {
    feedbackApi = [[FeedbackApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id feedback_contact:_feedbackContact.text feedback_content:_feedbackContent.text device_id:-1];
    feedbackApi.delegate = self;
    [feedbackApi start];
}



#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}

@end
