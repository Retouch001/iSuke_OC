//
//  CurrentDevice.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentDevice : NSObject
@property (nonatomic, copy) NSString *firmware_version;
@property (nonatomic, copy) NSString *software_version;
@property (nonatomic, assign) BOOL status;
@end
