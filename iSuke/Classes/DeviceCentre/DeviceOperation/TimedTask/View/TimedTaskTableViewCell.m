//
//  TimedTaskTableViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TimedTaskTableViewCell.h"
#import "TimedTaskModel.h"

@interface TimedTaskTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timedTaskTime;
@property (weak, nonatomic) IBOutlet UILabel *timedTaskDays;
@property (weak, nonatomic) IBOutlet UISwitch *timedTaskStatus;
@property (weak, nonatomic) IBOutlet UILabel *timedTaskAction;
@property (weak, nonatomic) IBOutlet UISwitch *timedTaskSwitch;


@end

@implementation TimedTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)freshCellWithTimedTask:(TimedTask *)timedTask{
    _timedTaskTime.text = [self parseTimedTaskTime:timedTask.timedtask_time];
    _timedTaskDays.text = [self parseTimedTaskDays:timedTask.timedtask_days];
    _timedTaskStatus.on = timedTask.timedtask_status;
    _timedTaskAction.text = timedTask.timedtask_action?RTLocalizedString(@"开启设备"):RTLocalizedString(@"关闭设备");
}

- (IBAction)timedTaskAction:(id)sender {
    self.switchClickBlock();
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSString *)parseTimedTaskDays:(NSString *)timedTaskDays{
    NSArray *weekDays = [timedTaskDays componentsSeparatedByString:@","];
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < weekDays.count; i++) {
        NSString *temp = weekDays[i];
        if (i == 0) {
            if ([temp isEqualToString:@"1"]) {
                [string appendString:RTLocalizedString(@"周一")];
            }else if ([temp isEqualToString:@"2"]){
                [string appendString:RTLocalizedString(@"周二")];
            }else if ([temp isEqualToString:@"3"]){
                [string appendString:RTLocalizedString(@"周三")];
            }else if ([temp isEqualToString:@"4"]){
                [string appendString:RTLocalizedString(@"周四")];
            }else if ([temp isEqualToString:@"5"]){
                [string appendString:RTLocalizedString(@"周五")];
            }else if ([temp isEqualToString:@"6"]){
                [string appendString:RTLocalizedString(@"周六")];
            }else{
                [string appendString:RTLocalizedString(@"周日")];
            }
        }else{
            if ([temp isEqualToString:@"1"]) {
                [string appendString:RTLocalizedString(@" 周一")];
            }else if ([temp isEqualToString:@"2"]){
                [string appendString:RTLocalizedString(@" 周二")];
            }else if ([temp isEqualToString:@"3"]){
                [string appendString:RTLocalizedString(@" 周三")];
            }else if ([temp isEqualToString:@"4"]){
                [string appendString:RTLocalizedString(@" 周四")];
            }else if ([temp isEqualToString:@"5"]){
                [string appendString:RTLocalizedString(@" 周五")];
            }else if ([temp isEqualToString:@"6"]){
                [string appendString:RTLocalizedString(@" 周六")];
            }else{
                [string appendString:RTLocalizedString(@" 周日")];
            }
        }
    }
    return string;
}

- (NSString *)parseTimedTaskTime:(NSString *)timedTaskTime{
    return [NSString stringWithFormat:@"%@:%@",[timedTaskTime substringToIndex:2],[timedTaskTime substringFromIndex:2]];
}

@end
