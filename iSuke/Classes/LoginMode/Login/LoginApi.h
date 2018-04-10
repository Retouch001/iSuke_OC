//
//  LoginApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

typedef NS_ENUM(NSInteger, RTLoginType){
    RTLoginTypePassword,
    RTLoginTypeVerifyCode
};


@interface LoginApi : RTBaseRequest


- (id)initWithCountryCode:(NSString *)countryCode phone:(NSString *)phone password:(NSString *)password loginType:(RTLoginType)loginType verifyCode:(NSString *)verifyCode;

@end
