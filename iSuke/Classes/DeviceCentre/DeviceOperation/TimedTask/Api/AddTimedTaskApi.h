//
//  AddTimedTaskApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"
#import "DeviceCentreModel.h"

@interface AddTimedTaskApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id  device_belong_type:(RTDeviceBelongType)device_belong_type timedtask_time:(NSString *)timedtask_time timedtask_days:(NSString *)timedtask_days timedtasdk_action:(NSInteger)timedtask_action;

@end
