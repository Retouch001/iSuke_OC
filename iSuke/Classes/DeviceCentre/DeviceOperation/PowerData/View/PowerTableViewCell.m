//
//  PowerTableViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PowerTableViewCell.h"

@interface PowerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;


@end


@implementation PowerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)freshCellWithPowerMonth:(PowerMonth *)powerMonth{
    _title.text = powerMonth.powerMonth;
    _detail.text = powerMonth.powerValue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
