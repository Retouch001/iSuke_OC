//
//  OperatingSwitchApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"
#import "DeviceDetailModel.h"
#import "DeviceCentreModel.h"


@interface OperatingSwitchApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id device_sub_id:(NSInteger)device_sub_id device_sub_num:(NSInteger)device_sub_num device_sub_status:(RTDeviceSubStatus)device_sub_status switch_type:(RTSwitchType)switch_type device_sub_alias:(NSString *)device_sub_alias total_switch_exist:(BOOL)total_switch_exist device_belong_type:(RTDeviceBelongType)devcie_belong_type;



@end
