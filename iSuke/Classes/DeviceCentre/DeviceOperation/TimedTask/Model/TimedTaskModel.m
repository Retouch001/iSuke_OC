//
//  TimedTaskModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TimedTaskModel.h"

@implementation TimedTask

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"timedtask_days" : [NSString class]
             };
}



@end

@implementation TimedTaskModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"timedTaskList" : [TimedTask class]
             };
}

@end
