//
//  CityModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/5/22.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "CityModel.h"

@implementation City


@end

@implementation CityModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"sceneCondition" : [City class],
             };
}
@end
