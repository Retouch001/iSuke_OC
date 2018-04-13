//
//  MessageCentreTableViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "MessageCentreTableViewCell.h"
#import "MessageModel.h"

@interface MessageCentreTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageTime;
@property (weak, nonatomic) IBOutlet UILabel *messageDate;

@end

@implementation MessageCentreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)freshCellWithMessage:(Message *)message{
    _messageTitle.text = message.message_title;
    _messageDate.text = message.message_date;
    _messageTime.text = message.message_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
