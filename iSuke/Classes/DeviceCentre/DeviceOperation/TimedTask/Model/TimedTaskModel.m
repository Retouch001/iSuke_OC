//
//  TimedTaskModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TimedTaskModel.h"

@implementation TimedTask

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"timedtask_days" : [NSString class]
             };
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}


//- (NSString *)timedtask_time{
//    return [NSString stringWithFormat:@"%@:%@",[_timedtask_time substringToIndex:2],[_timedtask_time substringFromIndex:2]];
//}
//
//
//- (NSString *)timedtask_days{
//    NSArray *weekDays = [_timedtask_days componentsSeparatedByString:@","];
//    NSMutableString *string = [NSMutableString string];
//    
//    for (int i = 0; i < weekDays.count; i++) {
//        NSString *temp = weekDays[i];
//        if (i == 0) {
//            if ([temp isEqualToString:@"1"]) {
//                [string appendString:RTLocalizedString(@"周一")];
//            }else if ([temp isEqualToString:@"2"]){
//                [string appendString:RTLocalizedString(@"周二")];
//            }else if ([temp isEqualToString:@"3"]){
//                [string appendString:RTLocalizedString(@"周三")];
//            }else if ([temp isEqualToString:@"4"]){
//                [string appendString:RTLocalizedString(@"周四")];
//            }else if ([temp isEqualToString:@"5"]){
//                [string appendString:RTLocalizedString(@"周五")];
//            }else if ([temp isEqualToString:@"6"]){
//                [string appendString:RTLocalizedString(@"周六")];
//            }else{
//                [string appendString:RTLocalizedString(@"周日")];
//            }
//        }else{
//            if ([temp isEqualToString:@"1"]) {
//                [string appendString:RTLocalizedString(@" 周一")];
//            }else if ([temp isEqualToString:@"2"]){
//                [string appendString:RTLocalizedString(@" 周二")];
//            }else if ([temp isEqualToString:@"3"]){
//                [string appendString:RTLocalizedString(@" 周三")];
//            }else if ([temp isEqualToString:@"4"]){
//                [string appendString:RTLocalizedString(@" 周四")];
//            }else if ([temp isEqualToString:@"5"]){
//                [string appendString:RTLocalizedString(@" 周五")];
//            }else if ([temp isEqualToString:@"6"]){
//                [string appendString:RTLocalizedString(@" 周六")];
//            }else{
//                [string appendString:RTLocalizedString(@" 周日")];
//            }
//        }
//    }
//    return string;
//}



@end

@implementation TimedTaskModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"timedTaskList" : [TimedTask class]
             };
}

@end
