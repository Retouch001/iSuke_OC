
//
//  SceneCollectionViewCell.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Scene;

@interface SceneCollectionViewCell : UICollectionViewCell

- (void)freshCellWithScene:(Scene *)scene editMode:(BOOL)editMode;

@end
