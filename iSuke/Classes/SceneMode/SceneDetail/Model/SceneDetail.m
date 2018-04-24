//
//  SceneDetail.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneDetail.h"



@implementation SceneDetail

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"sceneConditionList" : [SceneCondition class],
             @"sceneDeviceList" : [SceneDevice class]
             };
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

@end
