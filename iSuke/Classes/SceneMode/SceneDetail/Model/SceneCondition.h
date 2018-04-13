//
//  SceneCondition.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SceneCondition : NSObject

@property (nonatomic, assign) NSInteger condition_id;
@property (nonatomic, strong) NSString *condition_name;
@property (nonatomic, strong) NSArray *condition_option;
@property (nonatomic, strong) NSArray *condition_sub_option;


@end
