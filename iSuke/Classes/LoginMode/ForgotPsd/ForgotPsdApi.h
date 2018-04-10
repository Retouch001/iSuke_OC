//
//  ForgotPsdApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface ForgotPsdApi : RTBaseRequest

- (id)initWithVerifyCode:(NSString *)verifyCode password:(NSString *)password phone:(NSString *)phone;

@end
