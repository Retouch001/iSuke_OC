//
//  AddDeviceApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddDeviceApi.h"

@implementation AddDeviceApi{
    NSString *_device_mac;
    NSInteger _app_user_id;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id device_mac:(NSString *)device_mac{
    if (self  = [super init]) {
        _app_user_id = app_user_id;
        _device_mac = device_mac;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_ADD_DEVICE;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"device_no" : _device_mac
             };
}
@end
