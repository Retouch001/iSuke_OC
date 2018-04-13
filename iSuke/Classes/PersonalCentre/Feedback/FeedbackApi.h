//
//  FeedbackApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface FeedbackApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id feedback_contact:(NSString *)feedback_contact feedback_content:(NSString *)feedback_content  device_id:(NSInteger)device_id;

@end
