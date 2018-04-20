//
//  AddShareUserApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddShareUserApi.h"

@implementation AddShareUserApi{
    NSInteger _app_user_id;
    NSInteger _device_id;
    NSInteger _share_user_id;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id share_user_id:(NSInteger)share_user_id device_id:(NSInteger)device_id{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _device_id = device_id;
        _share_user_id = share_user_id;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_ADD_SHARE_USER;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"device_id" : @(_device_id),
             @"share_user_id" : @(_share_user_id)
             };
}

@end
