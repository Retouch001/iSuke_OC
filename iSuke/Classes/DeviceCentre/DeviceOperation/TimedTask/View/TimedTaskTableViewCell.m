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


@end

@implementation TimedTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)freshCellWithTimedTask:(TimedTask *)timedTask{
    _timedTaskTime.text = [NSString stringWithFormat:@"%@:%@",[timedTask.timedtask_time substringToIndex:2],[timedTask.timedtask_time substringFromIndex:2]];
    
    //NSArray *weekDays = [timedTask.timedtask_days componentsSeparatedByString:@","];
    _timedTaskDays.text = timedTask.timedtask_days;
    _timedTaskStatus.on = timedTask.timedtask_status;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
