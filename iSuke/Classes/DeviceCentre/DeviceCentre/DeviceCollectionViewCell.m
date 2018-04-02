//
//  DeviceCollectionViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceCollectionViewCell.h"

@interface DeviceCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@end



@implementation DeviceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"deviceCell";
    DeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)freshCellWihtIconString:(NSString *)iconString deviceName:(NSString *)deviceName{
    _iconImageView.image = [UIImage imageNamed:iconString];
    _deviceNameLabel.text = deviceName;
}

@end
