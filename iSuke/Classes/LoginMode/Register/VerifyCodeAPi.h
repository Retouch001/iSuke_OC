//
//  VerifyCodeAPi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/4.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

typedef NS_ENUM(NSInteger, RTGetVerifyCodeType) {
    RTGetVerifyCodeTypeRegister,
    RTGetVerifyCodeTypeFogotPsd,
    RTGetVerifyCodeTypeLogin
};



@interface VerifyCodeAPi : RTBaseRequest


- (id)initWithPhone:(NSString *)phone tag:(RTGetVerifyCodeType)tag country_code:(NSString *)country_code;

@end
