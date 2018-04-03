//
//  TriggerCollectionViewCell.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/3.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const reuseIdentifier = @"SceneModeCell";


@interface TriggerCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPaht;


- (void)freshCellWithIcon:(NSString *)icon title:(NSString *)title;


@end

