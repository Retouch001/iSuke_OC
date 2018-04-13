//
//  SceneCollectionViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneCollectionViewCell.h"
#import "SceneModel.h"

@interface SceneCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *sceneName;
@property (weak, nonatomic) IBOutlet UILabel *sceneStatus;


@end


@implementation SceneCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.whiteColor;
}


- (void)freshCellWithScene:(Scene *)scene{
    _icon.image = [UIImage imageNamed:@"ic_leave"];
    _sceneName.text = scene.scene_name;
    
    if (scene.scene_status) {
        _sceneStatus.text = RTLocalizedString(@"执行中");
        _sceneStatus.textColor = kColorTheme;
    }else{
        _sceneStatus.text = RTLocalizedString(@"未开启");
        _sceneStatus.textColor = kColorUnClickBtnBg;
    }
}

@end
