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
    
    DeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:nil options:nil] firstObject];
    }
    return cell;
}


- (void)freshCellWithIcon:(NSString *)icon deviceName:(NSString *)deviceName cellType:(RTCellType)cellType{
    _iconImageView.image = [UIImage imageNamed:icon];
    _deviceNameLabel.text = deviceName;
    switch (cellType) {
        case RTCellTypeDeviceCentre:
            _deviceNameLabel.textColor = kColorTheme;
            break;
        case RTCellTypeDeviceAdd:
            _deviceNameLabel.textColor = UIColor.blackColor;
            break;
        case RTCellTypeSceneMode:
            _deviceNameLabel.textColor = kColorTheme;
            break;
        default:
            break;
    }
}


- (void)freshCellWihtIconString:(NSString *)iconString deviceName:(NSString *)deviceName{

}

@end
