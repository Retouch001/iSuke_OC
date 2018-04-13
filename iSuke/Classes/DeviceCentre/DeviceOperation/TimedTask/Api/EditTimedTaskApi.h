//
//  EditTimedTaskApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface EditTimedTaskApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id timedtask_id:(NSInteger)timedtask_id timedtask_days:(NSString *)timedtask_days timedtask_action:(NSInteger)timedtask_action timedtask_status:(NSInteger)timedtask_status timedtask_time:(NSString *)timedtask_time;

@end
