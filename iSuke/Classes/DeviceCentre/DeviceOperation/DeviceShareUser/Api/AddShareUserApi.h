//
//  AddShareUserApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface AddShareUserApi : RTBaseRequest


- (id)initWithApp_user_id:(NSInteger)app_user_id share_user_phone:(NSString *)share_user_phone device_id:(NSInteger)device_id;

@end
