//
//  SceneDevice.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SceneDevice : NSObject

@property (nonatomic, copy) NSString *device_name;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger device_id;


@end
