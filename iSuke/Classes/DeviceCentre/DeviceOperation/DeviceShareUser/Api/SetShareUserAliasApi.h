//
//  SetShareUserAliasApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface SetShareUserAliasApi : RTBaseRequest

- (id)initWitApp_user_id:(NSInteger)app_user_id share_user_id:(NSInteger)share_user_id share_user_alias:(NSString *)share_user_alias;

@end
