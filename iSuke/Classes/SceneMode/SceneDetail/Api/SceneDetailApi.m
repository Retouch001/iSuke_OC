//
//  SceneDetailApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneDetailApi.h"

@implementation SceneDetailApi{
    NSInteger _app_user_id;
    NSInteger _scene_id;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id scene_id:(NSInteger)scene_id{
    if (self =[super init]) {
        _app_user_id = app_user_id;
        _scene_id  = scene_id;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_SCENE_DETAIL;
}


- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"scene_id" : @(_scene_id)
             };
}

@end
