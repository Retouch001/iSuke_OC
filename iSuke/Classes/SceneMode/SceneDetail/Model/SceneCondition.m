//
//  SceneCondition.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneCondition.h"

@implementation SceneCondition

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"condition_option" : [NSString class],
             @"condition_sub_option" : [NSString class]
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
