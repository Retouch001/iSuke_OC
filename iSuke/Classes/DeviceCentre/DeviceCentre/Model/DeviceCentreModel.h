//
//  DeviceCentreModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RTDeviceBelongType) {
    RTDeviceBelongTypeOwn,
    RTDeviceBelongTypeShare
};

@interface Device : NSObject

@property (nonatomic, assign) NSInteger device_user_id;//谁拥有的app_user_id

@property (nonatomic, assign) RTDeviceBelongType device_belong_type;

@property (nonatomic, copy) NSString *device_alias;
@property (nonatomic, assign) NSInteger device_id;

@property (nonatomic, copy) NSString *device_name;
@property (nonatomic, copy) NSString *device_mac;

@property (nonatomic, assign) NSInteger device_type;

@property (nonatomic, assign) NSInteger device_sub_id;


@end


@interface DeviceCentreModel : NSObject

@property (nonatomic, strong) NSArray<Device *> *deviceList;

@end
