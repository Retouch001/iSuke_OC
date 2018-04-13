//
//  DeleteTimedTaskApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface DeleteTimedTaskApi : RTBaseRequest


- (id)initWithApp_user_id:(NSInteger)app_user_id timedtask_id:(NSInteger)timedtask_id;

@end
