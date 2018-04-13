//
//  SceneDetail.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SceneCondition,Device;


@interface SceneDetail : NSObject

@property (nonatomic, copy) NSString *sceneName;
@property (nonatomic, copy) NSString *sceneCity;
@property (nonatomic, strong) SceneCondition *sceneCondition;
@property (nonatomic, strong) NSArray <SceneCondition *>*sceneConditionOption;
@property (nonatomic, assign) NSInteger sceneAction;
@property (nonatomic ,strong) NSArray <Device *>*sceneDeviceList;


@end


/*
 NSDictionary *dic = @{
 @"sceneName" : @"test",
 
 @"sceneCity" : @"深圳",
 
 @"sceneCondtionModel" : @{
 @"condition_name" : @"温度",
 @"condition_id" : @"1",
 @"codition_option" : @[@"大于",@"等于",@"小于"],
 @"condition_sub_option" : @[@"6",@"7",@"8",@"9"],
 },
 
 @"sceneConditionList" : @[ @{@"condition_name" : @"温度",
 @"condition_id" : @"1",
 @"codition_option" : @[@"大于",@"等于",@"小于"],
 @"condition_sub_option" : @[@"6",@"7",@"8",@"9"],
 },
 
 
 @{@"condition_name" : @"湿度",
 @"condition_id" : @"2",
 @"codition_option" : @[@"干燥",@"潮湿"],
 @"condition_sub_option" : @""
 },
 
 
 @{@"condition_name" : @"PM2.5",
 @"condition_id" : @"3",
 @"codition_option" : @[@"3",@"6"],
 @"condition_sub_option" : @""
 }
 ],
 
 @"sceneAction" : @"1",
 
 @"sceneDeviceList" : @[
 @{
 @"device_id" : @"45",
 @"device_nickname" : @"test",
 @"device_type" : @"1"
 },
 @{
 @"device_id" : @"45",
 @"device_nickname" : @"test",
 @"device_type" : @"1"
 },
 @{
 @"device_id" : @"45",
 @"device_nickname" : @"test",
 @"device_type" : @"1"
 }
 ]
 
 
 };
 **/