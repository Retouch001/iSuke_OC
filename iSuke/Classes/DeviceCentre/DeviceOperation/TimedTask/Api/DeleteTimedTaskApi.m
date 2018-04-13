//
//  DeleteTimedTaskApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeleteTimedTaskApi.h"

@implementation DeleteTimedTaskApi{
    NSInteger _app_user_id;
    NSInteger _timedtask_id;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id timedtask_id:(NSInteger)timedtask_id{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _timedtask_id = timedtask_id;
    }
    return self;
}



- (NSString *)requestUrl{
    return RT_DELETE_TIMEDTASK;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"timedtask_id" : @(_timedtask_id)
             };
}

@end
