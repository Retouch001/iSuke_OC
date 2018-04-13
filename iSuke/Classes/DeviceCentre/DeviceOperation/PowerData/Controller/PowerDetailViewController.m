//
//  PowerDetailViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PowerDetailViewController.h"
#import "DevicePowerDetailApi.h"
#import "DeviceCentreModel.h"
#import "PowerModel.h"
#import "PowerDetailModel.h"

@interface PowerDetailViewController ()<RTRequestDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@end



@implementation PowerDetailViewController{
    Device *_device;
    PowerModel *_powerModel;
    NSIndexPath *_indexPath;
    
    PowerDetailModel *powerDetailModel;
    
    DevicePowerDetailApi *powerDetailApi;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[_topBgView.backgroundColor hexString]);
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"86c059"]];
    
//    PowerYear *powerYear = _powerModel.powerData[_indexPath.section];
//    PowerMonth *powerMonth = powerYear.powerMonthList[_indexPath.row];
//    
//    
//    powerDetailApi = [[DevicePowerDetailApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id year:powerYear.year month:powerMonth.powerMonth];
//    powerDetailApi.delegate = self;
//    [powerDetailApi start];
}



#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{

    if ([request dataSuccess]) {
        powerDetailModel = [PowerDetailModel modelWithDictionary:request.responseObject];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{

}


@end
