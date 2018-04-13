//
//  GetTimedTaskApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "GetTimedTaskApi.h"

@implementation GetTimedTaskApi{
    NSInteger _app_user_id;
    NSInteger _device_id;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _device_id = device_id;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_GET_TIMEDTASK;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"device_id" : @(_device_id)
             };
}

@end
