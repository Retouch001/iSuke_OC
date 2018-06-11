//
//  RTUdpSocketManager.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "RTParseGenerateDataManager.h"

@protocol RTUdpSocketDelegate <GCDAsyncUdpSocketDelegate>

@end

@interface RTUdpSocketManager : NSObject
@property (nonatomic, weak) id<RTUdpSocketDelegate> delegate;
+ (instancetype)shareInstance;
- (void)sendDataWithData:(NSData *)data;
- (void)closeUdp;
@end
