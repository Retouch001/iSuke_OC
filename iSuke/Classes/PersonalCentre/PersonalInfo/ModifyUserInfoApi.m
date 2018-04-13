//
//  ModifyUserInfoApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ModifyUserInfoApi.h"

@implementation ModifyUserInfoApi{
    NSInteger _app_user_id;
    NSString *_nickname;
}



- (id)initWithApp_user_id:(NSInteger)app_user_id nickname:(NSString *)nickename{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _nickname = nickename;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_MODIFY_USERINFO;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"nickname" : _nickname
             };
}



@end
