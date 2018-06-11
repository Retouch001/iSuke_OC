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
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;


@end



@implementation DeviceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    DeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:nil options:nil] firstObject];
    }
    return cell;
}


- (void)freshCellWithDevice:(Device *)device editMode:(BOOL)editMode{
    _selectImageView.hidden = !editMode;
    _selectImageView.image = device.selected?[UIImage imageNamed:@"ic_choose3"]:[UIImage imageNamed:@"ic_choose2"];
    _deviceNameLabel.text = kStringIsEmpty(device.device_alias)?device.device_name:device.device_alias;
}

@end
