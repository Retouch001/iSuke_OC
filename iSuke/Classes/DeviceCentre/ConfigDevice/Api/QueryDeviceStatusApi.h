//
//  QueryDeviceStatusApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface QueryDeviceStatusApi : RTBaseRequest

- (id)initWithMac:(NSString *)mac;

@end
