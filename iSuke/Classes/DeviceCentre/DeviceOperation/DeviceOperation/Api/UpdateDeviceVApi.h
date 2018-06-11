//
//  UpdateDeviceVApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface UpdateDeviceVApi : RTBaseRequest
- (id)initWithDevice_mac:(NSString *)device_mac software_version:(NSString *)software_version;
@end
