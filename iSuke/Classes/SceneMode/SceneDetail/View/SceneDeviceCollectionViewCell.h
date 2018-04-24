//
//  SceneDeviceCollectionViewCell.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/23.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneDevice.h"

static NSString *const reuseDeviceIdentifier = @"SceneModeDeviceCell";

@interface SceneDeviceCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPaht;

- (void)freshCellWithSceneDevice:(SceneDevice *)sceneDevice;


@end
