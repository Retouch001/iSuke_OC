//
//  TimedTaskModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RTTimedTaskWeekType){
    RTTimedTaskWeekTypeMonday = 1,
    RTTimedTaskWeekTypeTuesday,
    RTTimedTaskWeekTypeWednesday,
    RTTimedTaskWeekTypeThursday,
    RTTimedTaskWeekTypeFriday,
    RTTimedTaskWeekTypeSaturday,
    RTTimedTaskWeekTypeSunday
};


@interface TimedTask : NSObject

@property (nonatomic, assign) NSInteger timedtask_id;
@property (nonatomic, assign) NSInteger timedtask_action;
@property (nonatomic, assign) NSInteger timedtask_status;
@property (nonatomic, copy) NSString *timedtask_time;
@property (nonatomic, copy) NSString *timedtask_days;

@end


@interface TimedTaskModel : NSObject

@property (nonatomic, strong) NSArray<TimedTask *> *timedTaskList;

@end
