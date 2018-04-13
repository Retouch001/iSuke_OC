//
//  FeedbackApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "FeedbackApi.h"

@implementation FeedbackApi{
    NSInteger _app_user_id;
    NSString *_feedback_contact;
    NSInteger _device_id;
    NSString *_feedback_content;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id feedback_contact:(NSString *)feedback_contact feedback_content:(NSString *)feedback_content  device_id:(NSInteger)device_id{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _feedback_contact = feedback_contact;
        _feedback_content = feedback_content;
        _device_id = device_id;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_FEEDBACK;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"feedback_contact" : _feedback_contact,
             @"feedback_content" : _feedback_content,
             @"device_id" : @(_device_id)
             };
}

@end
