//
//  RTAddinterceptor.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTAddinterceptor.h"

@implementation RTAddinterceptor

+ (void)addInterceptorWithMainUser:(MainUser *)mainUser{
    long timestamp = [NSDate date].timeIntervalSince1970;
    NSString *token = [[NSString stringWithFormat:@"%@%ldapp",mainUser.phone,timestamp] md5String];
    NSDictionary *argument = @{
                               @"orgId" : RT_ORGID,
                               @"phone" : mainUser.phone,
                               @"timestamp" : @(timestamp),
                               @"token" : token
                               };    
    
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    RTUrlArgumentsFilter *urlFilter = [RTUrlArgumentsFilter filterWithArguments:argument];
    [config addUrlFilter:urlFilter];
}

@end
