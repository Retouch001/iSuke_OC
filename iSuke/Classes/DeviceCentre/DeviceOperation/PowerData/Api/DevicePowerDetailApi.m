//
//  DevicePowerDetailApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DevicePowerDetailApi.h"

@implementation DevicePowerDetailApi{
    NSInteger _app_user_id;
    NSInteger _device_id;
    NSString  *_year;
    NSString  *_month;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id year:(NSString *)year month:(NSString *)month{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _device_id = device_id;
        _year = year;
        _month = month;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_DEVICE_POWER_DETAIL;
}


- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"device_id" : @(_device_id),
             @"year" : _year,
             @"month" : _month
             };
}

@end
