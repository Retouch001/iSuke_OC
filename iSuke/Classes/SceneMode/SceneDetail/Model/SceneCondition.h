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
@property (nonatomic, copy) NSString *condition_name;
@property (nonatomic, copy) NSString *normal_avatar;
@property (nonatomic, copy) NSString *hightLight_avatar;
@property (nonatomic, strong) NSArray<NSString *> *condition_option;
@property (nonatomic, strong) NSArray<NSString *> *condition_sub_option;


@end
