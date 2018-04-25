//
//  MessageDetailApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface MessageDetailApi : RTBaseRequest

- (id)initWithMessageId:(NSInteger)messageId;

@end
