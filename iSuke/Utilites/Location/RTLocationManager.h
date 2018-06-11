//
//  RTLocationManager.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^DidGetGeolocationsCompledBlock)(NSArray *placemarks);

@interface RTLocationManager : NSObject
+ (instancetype)sharedManager;
- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled;
@end
