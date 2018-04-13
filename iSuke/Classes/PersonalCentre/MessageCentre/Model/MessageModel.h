//
//  MessageModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, assign) NSInteger message_id;
@property (nonatomic, copy) NSString *message_date;
@property (nonatomic, copy) NSString *message_title;
@property (nonatomic, copy) NSString *message_time;


@end

@interface MessageModel : NSObject

@property (nonatomic, strong) NSArray<Message *> *messageList;

@end
