//
//  MessageDetailApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "MessageDetailApi.h"

@implementation MessageDetailApi{
    NSInteger _messageId;
}

- (id)initWithMessageId:(NSInteger)messageId{
    if (self = [super init]) {
        _messageId = messageId;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_GET_MESSAGES_DETAIL;
}

- (id)requestArgument{
    return @{@"message_id": @(_messageId)};
}

@end
