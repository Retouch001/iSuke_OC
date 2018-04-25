//
//  SetDeviceRemarkViewController.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceCentreModel.h"
#import "DeviceDetailModel.h"

@interface SetDeviceRemarkViewController : UIViewController

@property (nonatomic, strong) Device *device;
@property (nonatomic, strong) DeviceDetailInfo *deviceDetailInfo;
@end
