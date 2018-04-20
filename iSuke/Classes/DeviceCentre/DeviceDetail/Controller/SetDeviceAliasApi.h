//
//  SetDeviceAliasApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface SetDeviceAliasApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id device_sub_id:(NSInteger)device_sub_id device_sub_alias:(NSString *)device_sub_alias device_belong_type:(NSInteger)device_belong_type device_id:(NSInteger)device_id;


@end
