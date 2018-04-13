//
//  SetShareUserAliasApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SetShareUserAliasApi.h"

@implementation SetShareUserAliasApi{
    NSInteger _app_user_id;
    NSInteger _share_user_id;
    NSString *_share_user_alias;
}

- (id)initWitApp_user_id:(NSInteger)app_user_id share_user_id:(NSInteger)share_user_id share_user_alias:(NSString *)share_user_alias{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _share_user_id = share_user_id;
        _share_user_alias = share_user_alias;
    }
    return self;
}



- (NSString *)requestUrl{
    return RT_SET_SHAREUSER_ALIAS;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"share_user_id" : @(_share_user_id),
             @"share_user_alias" : _share_user_alias
             };
}


@end
