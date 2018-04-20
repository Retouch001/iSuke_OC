//
//  QueryUserApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/17.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "QueryUserApi.h"

@implementation QueryUserApi{
    NSString *_share_user_phone;
}


- (id)initWithShare_user_phone:(NSString *)share_user_phone{
    if (self = [super init]) {
        _share_user_phone = share_user_phone;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_QUERY_USER;
}

- (id)requestArgument{
    return @{
             @"share_user_phone" : _share_user_phone
             };
}

@end
