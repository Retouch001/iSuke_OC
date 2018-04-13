//
//  DeleteSceneApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeleteSceneApi.h"

@implementation DeleteSceneApi{
    NSInteger _app_user_id;
    NSString *_scene_ids;
}

- (id)initWithApp_user_id:(NSInteger)app_user_id scene_ids:(NSString *)scene_ids{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _scene_ids = scene_ids;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_DELETE_SCENE;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"scene_ids" : _scene_ids
             };
}

@end
