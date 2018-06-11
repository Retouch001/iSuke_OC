//
//  SearchDeviceVApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SearchDeviceVApi.h"

@implementation SearchDeviceVApi{
    NSString *_device_mac;
}

- (id)initWithDevice_mac:(NSString *)device_mac{
    if (self = [super init]) {
        _device_mac = device_mac;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_SEARCH_DEVICE_V;
}

- (id)requestArgument{
    return @{
             @"device_mac" : _device_mac
             };
}

@end
