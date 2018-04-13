//
//  AddSceneApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddSceneApi.h"
#import "SceneCondition.h"

@implementation AddSceneApi{
    NSInteger _app_user_id;
    NSString *_scene_name;
    NSInteger _device_status;
    NSString *_scene_city;
    NSString *_devie_ids;
    NSInteger _condition_id;
    NSString *_condition_option;
    NSString *_condition_sub_option;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id scene_name:(NSString *)scene_name device_status:(NSInteger)device_status scene_city:(NSString *)scene_city device_ids:(NSString *)device_ids condition_id:(NSInteger)condition_id condition_option:(NSString *)codition_option condition_sub_option:(NSString *)condition_sub_option{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _scene_city = scene_city;
        _scene_name = scene_name;
        _devie_ids = device_ids;
        _condition_id = condition_id;
        _condition_option = codition_option;
        _condition_sub_option = condition_sub_option;
        _device_status = device_status;
    }
    return self;
}



- (NSString *)requestUrl{
    return RT_ADD_SCENE;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"scene_city" : _scene_city,
             @"scene_name" : _scene_name,
             @"device_ids" : _devie_ids,
             @"device_status" : @(_device_status),
             @"condition_id" : @(_condition_id),
             @"condition_option" : _condition_option,
             @"condition_sub_option" : _condition_sub_option
             };
}

@end
