//
//  AddTimedTaskApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddTimedTaskApi.h"

@implementation AddTimedTaskApi{
    NSInteger _app_user_id;
    NSInteger _device_id;
    RTDeviceBelongType _device_belong_type;
    NSString *_timedtask_time;
    NSString *_timedtask_days;
    NSInteger _timedtask_action;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id device_belong_type:(RTDeviceBelongType)device_belong_type timedtask_time:(NSString *)timedtask_time timedtask_days:(NSString *)timedtask_days timedtasdk_action:(NSInteger)timedtask_action{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _device_id = device_id;
        _device_belong_type = device_belong_type;
        _timedtask_time = timedtask_time;
        _timedtask_days = timedtask_days;
        _timedtask_action = timedtask_action;
    }
    return self;
}



- (NSString *)requestUrl{
    return RT_ADD_TIMEDTASK;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"device_id" : @(_device_id),
             @"device_belong_type" : @(_device_belong_type),
             @"timedtask_time" : _timedtask_time,
             @"timedtask_days" : _timedtask_days,
             @"timedtask_action" : @(_timedtask_action)
             };
}



@end
