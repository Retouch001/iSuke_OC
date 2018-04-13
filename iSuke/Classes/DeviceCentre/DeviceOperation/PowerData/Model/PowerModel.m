//
//  PowerModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PowerModel.h"

@implementation PowerModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"powerData" : [PowerYear class]
             };
}

@end
