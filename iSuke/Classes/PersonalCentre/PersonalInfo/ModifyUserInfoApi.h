//
//  ModifyUserInfoApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface ModifyUserInfoApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id nickname:(NSString *)nickename;

@end
