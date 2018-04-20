//
//  AddTimingTableViewController.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RTTimedTaskVCType) {
    RTTimedTaskVCTypeAdd,
    RTTimedTaskVCTypeEdit
};

@interface AddTimingTableViewController : UITableViewController

@property (nonatomic, assign) RTTimedTaskVCType timedTaskVCType;

@end
