//
//  RegisterApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/4.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi{
    NSString *_country_code;
    NSString *_phone;
    NSString *_password;
    NSString *_verifycode;
}


- (id)initWithCountry_code:(NSString *)country_code phone:(NSString *)phone psd:(NSString *)psd verifycode:(NSString *)verifycode{
    if (self = [super init]) {
        if ([country_code containsString:@"+"]) {
            country_code = [country_code substringFromIndex:1];
        }
        _country_code = country_code;
        _phone = phone;
        _password = psd;
        _verifycode = verifycode;
    }
    return self;
}


- (NSString *)requestUrl {
    return RT_REGISTER_URL;
}


- (id)requestArgument {
    return @{
             @"country_code": _country_code,
             @"phone" : _phone,
             @"verifycode" : _verifycode,
             @"password": _password,
             @"appSerialNum" : RT_APPSERIALNUM,
             @"appOrgCode" : RT_APPORGCODE,
             @"orgId" : RT_ORGID
             };
}

//- (id)jsonValidator {
//    return @{
//             @"userId": [NSNumber class],
//             @"nick": [NSString class],
//             @"level": [NSNumber class]
//             };
//}
//



@end
