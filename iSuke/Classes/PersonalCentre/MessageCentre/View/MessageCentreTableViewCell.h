//
//  MessageCentreTableViewCell.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Message;

@interface MessageCentreTableViewCell : UITableViewCell

- (void)freshCellWithMessage:(Message *)message;

@end
