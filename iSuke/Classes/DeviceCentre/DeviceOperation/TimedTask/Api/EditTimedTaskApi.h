//
//  EditTimedTaskApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"
#import "DeviceCentreModel.h"
#import "TimedTaskModel.h"

@interface EditTimedTaskApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id timedTask:(TimedTask *)timedTask;

@end
