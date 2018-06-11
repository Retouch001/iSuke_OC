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
    NSString *_login_phone;
    NSString *_password;
    long _login_timestamp;
    NSString *_login_token;
    
    RTLoginType _loginType;
    NSString *_verifyCode;
}

- (id)initWithCountryCode:(NSString *)countryCode phone:(NSString *)phone password:(NSString *)password loginType:(RTLoginType)loginType verifyCode:(NSString *)verifyCode{
    if (self = [super init]) {
        if ([countryCode containsString:@"+"]) {
            countryCode = [countryCode substringFromIndex:1];
        }
        _country_code = countryCode;
        _login_phone = phone;
        _password = password;
        
        _loginType = loginType;
        _verifyCode = verifyCode;
        
        _login_timestamp = [NSDate date].timeIntervalSince1970;
        
        switch (loginType) {
            case RTLoginTypePassword:
                _login_token = [[NSString stringWithFormat:@"%@%@%ldapp",_login_phone,[_password md5String],_login_timestamp] md5String];
                break;
            case RTLoginTypeVerifyCode:
                _login_token = [[NSString stringWithFormat:@"%@%@%ldapp",_login_phone,_verifyCode,_login_timestamp] md5String];
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
             @"login_phone" : _login_phone,
             @"password": [_password md5String],
             
             @"type" : @(_loginType),
             @"verifycode" : _verifyCode,
             
             @"login_timestamp" : @(_login_timestamp),
             @"login_token" : _login_token,
             
             @"appSerialNum" : RT_APPSERIALNUM,
             @"appOrgCode" : RT_APPORGCODE,
             @"orgId" : RT_ORGID
             };
}
@end
