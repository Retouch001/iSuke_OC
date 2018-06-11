//
//  SceneChangeTableViewController.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RTSceneChangeType){
    RTSceneChangeTypeEdit,
    RTSceneChangeTypeAdd
};

@interface SceneChangeTableViewController : UITableViewController

@property (nonatomic, assign) RTSceneChangeType sceneChangeType;

@end
