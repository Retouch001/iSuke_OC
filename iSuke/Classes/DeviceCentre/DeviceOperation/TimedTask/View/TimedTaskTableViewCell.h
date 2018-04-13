//
//  TimedTaskTableViewCell.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimedTask;

@interface TimedTaskTableViewCell : UITableViewCell


- (void)freshCellWithTimedTask:(TimedTask *)timedTask;

@end
