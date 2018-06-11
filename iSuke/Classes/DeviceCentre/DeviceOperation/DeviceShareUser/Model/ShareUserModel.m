//
//  ShareUserModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ShareUserModel.h"

@implementation ShareUser

@end

@implementation ShareUserModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"shareUserList" : [ShareUser class]
             };
}

@end
