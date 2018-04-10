//
//  ForgotPsdApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ForgotPsdApi.h"

@implementation ForgotPsdApi{
    NSString *_verifyCode;
    NSString *_phone;
    NSString *_password;
}


- (id)initWithVerifyCode:(NSString *)verifyCode password:(NSString *)password phone:(NSString *)phone{
    if (self = [super init]) {
        _verifyCode = verifyCode;
        _password = password;
        _phone = phone;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_FORGET_PSD;
}

- (id)requestArgument{
    return @{
             @"phone" : _phone,
             @"password" : [_password md5String],
             @"verifycode" : _verifyCode,
             @"orgId" : RT_ORGID
             };
}

@end
