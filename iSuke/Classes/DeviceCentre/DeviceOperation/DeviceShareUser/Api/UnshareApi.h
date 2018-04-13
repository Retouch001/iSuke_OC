//
//  UnshareApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface UnshareApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id device_id:(NSInteger)device_id share_user_id:(NSInteger)share_user_id;

@end