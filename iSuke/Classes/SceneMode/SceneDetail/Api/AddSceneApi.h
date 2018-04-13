//
//  AddSceneApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"
@class SceneCondition;

@interface AddSceneApi : RTBaseRequest


- (id)initWithApp_user_id:(NSInteger)app_user_id scene_name:(NSString *)scene_name device_status:(NSInteger)device_status scene_city:(NSString *)scene_city device_ids:(NSString *)device_ids condition_id:(NSInteger)condition_id condition_option:(NSString *)codition_option condition_sub_option:(NSString *)condition_sub_option;

@end
