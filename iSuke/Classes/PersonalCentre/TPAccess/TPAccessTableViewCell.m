//
//  TPAccessTableViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TPAccessTableViewCell.h"

@interface TPAccessTableViewCell (){
    NSArray *_iconArray;
    NSArray *_titleArray;
    NSArray *_detailArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@end

@implementation TPAccessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconArray = @[@"ic_echo",@"ic_googlehome"];
    _titleArray = @[RTLocalizedString(@"Amazon Echo"), RTLocalizedString(@"Google Home")];
    _detailArray = @[RTLocalizedString(@"请先添加支持Echo的设备"), RTLocalizedString(@"请先添加支持Google Home的设备")];
}

- (void)freshCellWithIndexpath:(NSIndexPath *)indexpath{
    _icon.image = [UIImage imageNamed:_iconArray[indexpath.section]];
    _title.text = _titleArray[indexpath.section];
    _detail.text = _detailArray[indexpath.section];
}

@end
