//
//  RTUrlArgumentsFilter.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/9.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTNetworkConfig.h"
#import "RTBaseRequest.h"

@interface RTUrlArgumentsFilter : NSObject<RTUrlFilterProtocol>

+ (RTUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;


@end
