//
//  WeekSelectTableViewController.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/17.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekSelectTableViewController : UITableViewController


@property (nonatomic, copy) void(^block)(NSString *selectedWeeks);

@end
