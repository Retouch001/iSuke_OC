//
//  PowerYear.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PowerYear.h"

@implementation PowerMonth


@end


@implementation PowerYear

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"powerMonthList" : [PowerMonth class]
             };
}

@end
