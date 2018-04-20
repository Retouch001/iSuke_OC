//
//  QueryDeviceStatusApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "QueryDeviceStatusApi.h"

@implementation QueryDeviceStatusApi{
    NSString *_device_mac;
}


- (id)initWithMac:(NSString *)mac{
    if (self = [super init]) {
        _device_mac = mac;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_QUERY_DEVICE;
}

- (id)requestArgument{
    return @{
             @"device_mac" : _device_mac
             };
}

@end
