//
//  EditTimedTaskApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "EditTimedTaskApi.h"

@implementation EditTimedTaskApi{
    NSInteger _app_user_id;
    NSInteger _timedtask_id;
    NSString *_timedtask_days;
    NSInteger _timedtask_action;
    NSInteger _timedtask_stauts;
    NSString *_timedtask_time;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id timedtask_id:(NSInteger)timedtask_id timedtask_days:(NSString *)timedtask_days timedtask_action:(NSInteger)timedtask_action timedtask_status:(NSInteger)timedtask_status timedtask_time:(NSString *)timedtask_time{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _timedtask_id = timedtask_id;
        _timedtask_days = timedtask_days;
        _timedtask_action = timedtask_action;
        _timedtask_stauts = timedtask_status;
        _timedtask_time = timedtask_time;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_EDIT_TIMEDTASK;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"timedtask_id" : @(_timedtask_id),
             @"timedtask_days" : _timedtask_days,
             @"timedtask_action" : @(_timedtask_action),
             @"timedtask_status" : @(_timedtask_stauts),
             @"timedtask_time" : _timedtask_time
             };
}

@end
