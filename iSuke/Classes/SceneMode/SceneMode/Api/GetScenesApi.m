//
//  GetScenesApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "GetScenesApi.h"

@implementation GetScenesApi{
    NSInteger _app_user_id;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id{
    if (self = [super init]) {
        _app_user_id = app_user_id;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_GET_SCENE;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id)
             };
}

@end
