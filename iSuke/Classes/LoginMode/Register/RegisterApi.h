//
//  RegisterApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/4.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface RegisterApi : RTBaseRequest

- (id)initWithCountry_code:(NSString *)country_code phone:(NSString *)phone psd:(NSString *)psd verifycode:(NSString *)verifycode;


@end
