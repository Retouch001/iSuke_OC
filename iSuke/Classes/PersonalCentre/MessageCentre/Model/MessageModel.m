//
//  MessageModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "MessageModel.h"

@implementation Message


@end

@implementation MessageModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"messageList" : [Message class]
             };
}

@end
