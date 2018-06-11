//
//  RTLocationManager.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTLocationManager.h"

@interface RTLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) DidGetGeolocationsCompledBlock didGetGeolocationsCompledBlock;
@end

@implementation RTLocationManager
+ (instancetype)sharedManager {
    static RTLocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate  = self;
        _locationManager.distanceFilter  = 100 ;
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled {
    self.didGetGeolocationsCompledBlock = compled;
    if ([CLLocationManager locationServicesEnabled]) {
        [_locationManager startUpdatingLocation];
    }
}


#pragma mark - CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (self.didGetGeolocationsCompledBlock) {
            self.didGetGeolocationsCompledBlock(placemarks);
        }
    }];
    [manager stopUpdatingLocation];
}


//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (self.didGetGeolocationsCompledBlock) {
//            self.didGetGeolocationsCompledBlock(placemarks);
//        }
//    }];
//    [manager stopUpdatingLocation];
//}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
}

@end
