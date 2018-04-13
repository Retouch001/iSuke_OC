//
//  PowerYear.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PowerMonth : NSObject

@property (nonatomic, copy) NSString *powerValue;
@property (nonatomic, copy) NSString *powerMonth;

@end


@interface PowerYear : NSObject

@property (nonatomic, copy) NSString *year;
@property (nonatomic, strong) NSArray <PowerMonth *> *powerMonthList;

@end
