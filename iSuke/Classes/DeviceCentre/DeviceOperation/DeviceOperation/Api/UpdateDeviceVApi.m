//
//  UpdateDeviceVApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "UpdateDeviceVApi.h"

@implementation UpdateDeviceVApi{
    NSString *_device_mac;
    NSString *_software_verison;
}

- (id)initWithDevice_mac:(NSString *)device_mac software_version:(NSString *)software_version{
    if (self = [super init]) {
        _device_mac = device_mac;
        _software_verison = software_version;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_UPDATE_DEVICE_V;
}

- (id)requestArgument{
    return @{
             @"device_mac" : _device_mac,
             @"software_version" : _software_verison
             };
}

@end
