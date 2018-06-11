//
//  DeviceCollectionViewCell.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceCentreModel.h"


static NSString * const reuseIdentifier = @"deviceCell";


@interface DeviceCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPaht;

- (void)freshCellWithDevice:(Device *)device editMode:(BOOL)editMode;


@end
