//
//  SceneDeviceCollectionViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/23.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneDeviceCollectionViewCell.h"

@interface SceneDeviceCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation SceneDeviceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    SceneDeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseDeviceIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseDeviceIdentifier owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)freshCellWithSceneDevice:(SceneDevice *)sceneDevice{
    _title.text = sceneDevice.device_name;
    if (sceneDevice.selected) {
        self.backgroundColor = kColorTheme;
    }else{
        self.backgroundColor = [UIColor colorWithHexString:@"9c9c9c"];
    }
}

@end
