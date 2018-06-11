//
//  TimeZoneTableViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TimeZoneTableViewCell.h"

@interface TimeZoneTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation TimeZoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)freshCellWithString:(NSString *)string{
    self.title.text = @"中国";
    self.detail.text = string;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
