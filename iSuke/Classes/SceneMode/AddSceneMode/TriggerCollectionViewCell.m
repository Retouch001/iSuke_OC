//
//  TriggerCollectionViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/3.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TriggerCollectionViewCell.h"

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



- (void)freshCellWithIcon:(NSString *)icon title:(NSString *)title{
    _icon.image = [UIImage imageNamed:icon];
    _title.text = title;
}

@end
