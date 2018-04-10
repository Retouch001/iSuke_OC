//
//  LoginApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "LoginApi.h"

@implementation LoginApi{
    NSString *_country_code;
    NSString *_phone;
    NSString *_password;
    long _timestamp;
    NSString *_token;
    
    RTLoginType _loginType;
    NSString *_verifyCode;
}


- (id)initWithCountryCode:(NSString *)countryCode phone:(NSString *)phone password:(NSString *)password loginType:(RTLoginType)loginType verifyCode:(NSString *)verifyCode{
    if (self = [super init]) {
        _country_code = countryCode;
        _phone = phone;
        _password = password;
        
        _loginType = loginType;
        _verifyCode = verifyCode;
        
        _timestamp = [NSDate date].timeIntervalSince1970;
        
        switch (loginType) {
            case RTLoginTypePassword:
                _token = [[NSString stringWithFormat:@"%@%@%ldapp",_phone,[_password md5String],_timestamp] md5String];
                break;
            case RTLoginTypeVerifyCode:
                _token = [[NSString stringWithFormat:@"%@%@%ldapp",_phone,_verifyCode,_timestamp] md5String];
                break;
            default:
                break;
        }        
    }
    return self;
}



- (NSString *)requestUrl {
    return RT_LOGIN_URL;
}


- (id)requestArgument {
    return @{
             @"country_code": _country_code,
             @"phone" : _phone,
             @"password": _password,
             
             @"type" : @(_loginType),
             @"verifycode" : _verifyCode,
             
             @"timestamp" : @(_timestamp),
             @"token" : _token,
             
             @"appSerialNum" : RT_APPSERIALNUM,
             @"appOrgCode" : RT_APPORGCODE,
             @"orgId" : RT_ORGID
             };
}



@end
