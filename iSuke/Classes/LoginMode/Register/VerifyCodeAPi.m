//
//  VerifyCodeAPi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/4.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "VerifyCodeAPi.h"

@implementation VerifyCodeAPi{
    NSString *_phone;
    NSInteger _tag;
    NSString *_country_code;
}


- (id)initWithPhone:(NSString *)phone tag:(RTGetVerifyCodeType)tag country_code:(NSString *)country_code{
    if (self = [super init]) {
        if ([country_code containsString:@"+"]) {
            country_code = [country_code substringFromIndex:1];
        }
        _phone = phone;
        _tag = tag;
        _country_code = country_code;
    }
    return self;
}


- (NSString *)requestUrl{
    return RT_GET_CAPTCHA_URL;
}

- (id)requestArgument{
    return @{
             @"phone" : _phone,
             @"country_code" : _country_code,
             @"tag" : @(_tag),
             @"orgId" : RT_ORGID
             };
}



@end
