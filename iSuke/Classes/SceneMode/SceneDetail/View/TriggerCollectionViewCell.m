//
//  TriggerCollectionViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/3.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TriggerCollectionViewCell.h"
#import "RTNetworkConfig.h"

@interface TriggerCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation TriggerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SceneModeCell";
    TriggerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)freshCellWithSceneCodition:(SceneCondition *)sceneCondition selectedCondition:(SceneCondition *)selectedCondition{
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    NSURL *url;
    if (selectedCondition.condition_id == sceneCondition.condition_id) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",config.baseUrl,RT_ICON_BASE,sceneCondition.hightLight_avatar]];
        _title.textColor = kColorTheme;
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",config.baseUrl,RT_ICON_BASE,sceneCondition.normal_avatar]];
        _title.textColor = UIColor.blackColor;
    }
    [_icon setImageWithURL:url placeholder:nil];
    _title.text = sceneCondition.condition_name;
}


@end
