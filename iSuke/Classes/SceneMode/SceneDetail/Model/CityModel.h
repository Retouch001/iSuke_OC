//
//  CityModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/5/22.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, copy) NSString *country_cn;
@property (nonatomic, copy) NSString *country_eng;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *city_cn;
@property (nonatomic, copy) NSString *city_eng;

@end

@interface CityModel : NSObject

@property (nonatomic, strong) NSArray<City *> *sceneCondition;

@end
