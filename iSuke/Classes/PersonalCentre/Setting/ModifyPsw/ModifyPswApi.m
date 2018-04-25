//
//  ModifyPswApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ModifyPswApi.h"

@implementation ModifyPswApi{
    NSInteger _app_user_id;
    NSString *_old_password;
    NSString *_new_password;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id oldPsw:(NSString *)oldPsw newPsw:(NSString *)newPsw{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _old_password = oldPsw;
        _new_password = newPsw;
    }
    return self;
}

- (NSString *)requestUrl{
    return RT_MODIFY_PWD;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id),
             @"old_password" : [_old_password md5String],
             @"new_password" : [_new_password md5String]
             };
}

@end
