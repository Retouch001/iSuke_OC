//
//  PowerModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerYear.h"

@interface Power : NSObject

@property (nonatomic, assign) CGFloat todayPower;
@property (nonatomic, assign) CGFloat currentVoltage;
@property (nonatomic, assign) CGFloat currentElectricity;
@property (nonatomic, assign) CGFloat currentPower;
@property (nonatomic, assign) CGFloat totalPower;

@end

@interface PowerModel : NSObject


@property (nonatomic, strong) Power *powerGeneral;
@property (nonatomic, strong) NSArray<PowerYear *> *powerData;


@end
