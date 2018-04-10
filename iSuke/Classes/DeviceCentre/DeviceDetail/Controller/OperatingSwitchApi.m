//
//  OperatingSwitchApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "OperatingSwitchApi.h"

@implementation OperatingSwitchApi{
    NSInteger _app_user_id;
    NSInteger _device_id;
    NSInteger _device_sub_id;
    NSInteger _device_sub_num;
    RTDeviceSubStatus _device_sub_status;
    RTSwitchType _switch_type;
    NSString *_device_sub_alias;
    BOOL _total_swith_exist;
    RTDeviceBelongType _device_belong_type;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id device_sub_id:(NSInteger)device_sub_id device_sub_num:(NSInteger)device_sub_num device_sub_status:(RTDeviceSubStatus)device_sub_status switch_type:(RTSwitchType)switch_type device_sub_alias:(NSString *)device_sub_alias total_switch_exist:(BOOL)total_switch_exist device_belong_type:(RTDeviceBelongType)devcie_belong_type{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _device_id = device_id;
        _device_sub_id = device_sub_id;
        _device_sub_num = device_sub_num;
        _device_sub_status = device_sub_status;
        _switch_type = switch_type;
        _device_sub_alias = device_sub_alias;
        _total_swith_exist = total_switch_exist;
        _device_belong_type = devcie_belong_type;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_OPERATE_SWITCH;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"device_id" : @(_device_id),
             @"device_sub_id" : @(_device_sub_id),
             @"device_sub_num" : @(_device_sub_num),
             @"device_sub_status" : @(_device_sub_status),
             @"switch_type" : @(_switch_type),
             @"device_sub_alias" : _device_sub_alias,
             @"total_switch_exist" : @(_total_swith_exist),
             @"device_belong_type" : @(_device_belong_type)
             };
}


@end
