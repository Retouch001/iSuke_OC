//
//  DeviceCentreModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceCentreModel.h"

@implementation Device

@end



@implementation DeviceCentreModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"deviceList" : [Device class]};
}
@end
