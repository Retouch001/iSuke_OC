//
//  SetDeviceAliasApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SetDeviceAliasApi.h"

@implementation SetDeviceAliasApi{
    NSInteger _app_user_id;
    NSInteger _device_sub_id;
    NSString *_device_sub_alias;
    NSInteger _device_belong_type;
    NSInteger _device_id;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id device_sub_id:(NSInteger)device_sub_id device_sub_alias:(NSString *)device_sub_alias device_belong_type:(NSInteger)device_belong_type device_id:(NSInteger)device_id{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _device_sub_id = device_sub_id;
        _device_sub_alias = device_sub_alias;
        _device_belong_type = device_belong_type;
        _device_id = device_id;
    }
    return self;
}



- (NSString *)requestUrl{
    return RT_SETDEVICE_ALIAS;
}

- (id)requestArgument{
    return @{
             @"device_id" : @(_device_id),
             @"app_user_id" : @(_app_user_id),
             @"device_sub_id" : @(_device_sub_id),
             @"device_sub_alias" : _device_sub_alias,
             @"device_belong_type" : @(_device_belong_type)
             };
}


@end
