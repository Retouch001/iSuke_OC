//
//  EditSceneApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "EditSceneApi.h"

@implementation EditSceneApi{
    NSInteger _app_user_id;
    NSInteger _scene_id;
    NSInteger _scene_status;
    NSString *_scene_name;
    NSInteger _device_status;
    NSString *_scene_city;
    NSString *_devie_ids;
    NSInteger _condition_id;
    NSString *_condition_option;
    NSString *_condition_sub_option;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id scene:(Scene *)scene sceneDetail:(SceneDetail *)sceneDetail{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _scene_name = scene.scene_name;
        _scene_id = scene.scene_id;
        _scene_status = scene.scene_status;
        
        _scene_city = sceneDetail.scene_city;
        _condition_id = sceneDetail.sceneCondition.condition_id;
        _condition_option = sceneDetail.sceneCondition.condition_option.firstObject;
        if (sceneDetail.sceneCondition.condition_sub_option.count > 0) {
            _condition_sub_option = sceneDetail.sceneCondition.condition_sub_option.firstObject;
        }else{
            _condition_sub_option = @"";
        }
        _device_status = sceneDetail.device_status;
        NSMutableString *string = [NSMutableString string];
        for (int i = 0; i < sceneDetail.sceneDeviceList.count; i++) {
            SceneDevice *device = sceneDetail.sceneDeviceList[i];
            if (string.length > 0) {
                if (device.selected) {
                    [string appendString:[NSString stringWithFormat:@",%ld",device.device_id]];
                }
            }else{
                if (device.selected) {
                    [string appendString:[NSString stringWithFormat:@"%ld",device.device_id]];
                }
            }
        }
        _devie_ids = string;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_EDIT_SCENE;
}


- (id)requestArgument{
    NSLog(@"哈哈哈哈哈哈哈哈----%@",_devie_ids);
    return @{
             @"app_user_id" : @(_app_user_id),
             @"scene_id" : @(_scene_id),
             @"scene_status" : @(_scene_status),
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
