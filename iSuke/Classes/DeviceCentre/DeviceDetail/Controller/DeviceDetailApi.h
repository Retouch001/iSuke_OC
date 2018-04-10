//
//  DeviceDetailApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"
#import "DeviceCentreModel.h"


@interface DeviceDetailApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id device_belong_type:(RTDeviceBelongType)device_belong_type;

@end
