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

@interface AddShareUserSecondViewController ()<RTRequestDelegate>{
    NSString *_phone;
    Device *_device;
    
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
}


- (IBAction)comfirmAciton:(id)sender {
    addShareUserApi = [[AddShareUserApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id share_user_phone:_phone device_id:_device.device_id];
    addShareUserApi.delegate = self;
    [addShareUserApi start];
}



#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end
