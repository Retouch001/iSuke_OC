//
//  PowerDetailModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PowerDetail : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger powerValue;

@end

@interface PowerDetailModel : NSObject

@property (nonatomic, strong) NSArray<PowerDetail *> *powerDetail;

@end
