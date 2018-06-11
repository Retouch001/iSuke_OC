//
//  DeleteDeviceApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeleteDeviceApi.h"

@implementation DeleteDeviceApi{
    NSInteger _app_user_id;
    NSString *_deviceId_userId;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id deviceId_userId:(NSString *)deviceId_userId{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _deviceId_userId = deviceId_userId;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_DELETE_DEVICE;
}


- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"deviceId_userId" : _deviceId_userId
             };
}

@end
