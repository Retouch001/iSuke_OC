//
//  DeviceDetailModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, RTSwitchType){
    RTSwitchTypeMain,
    RTSwitchTypeSub
};

typedef NS_ENUM(NSInteger, RTDeviceSubStatus) {
    RTDeviceSubStatusOn,
    RTDeviceSubStatusOff
};


@interface DeviceDetailInfo : NSObject

@property (nonatomic, strong) NSString *device_sub_alias;
@property (nonatomic, assign) NSInteger device_sub_id;
@property (nonatomic, assign) NSInteger device_sub_num;
@property (nonatomic, assign) RTSwitchType switch_type;
@property (nonatomic, assign) RTDeviceSubStatus device_sub_status;
@property (nonatomic, assign) BOOL total_switch_exist;

@end



@interface DeviceDetailModel : NSObject

@property (nonatomic, strong) NSArray<DeviceDetailInfo *> *deviceDetail;

@end


