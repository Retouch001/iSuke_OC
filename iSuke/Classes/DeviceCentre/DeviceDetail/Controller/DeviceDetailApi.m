//
//  DeviceDetailApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceDetailApi.h"

@implementation DeviceDetailApi{
    NSInteger _app_user_id;
    NSInteger _device_id;
    RTDeviceBelongType _device_belong_type;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id device_belong_type:(RTDeviceBelongType)device_belong_type{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _device_id = device_id;
        _device_belong_type = device_belong_type;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_DEVICE_DETAIL;
}


- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"device_id" : @(_device_id),
             @"device_belong_type" : @(_device_belong_type)
             };
}

@end
