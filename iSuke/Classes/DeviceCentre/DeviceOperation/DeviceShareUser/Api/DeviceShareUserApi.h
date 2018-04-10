//
//  DeviceShareUserApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface DeviceShareUserApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id;

@end
