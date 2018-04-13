//
//  SceneModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scene : NSObject

@property (nonatomic, assign) NSInteger scene_id;
@property (nonatomic,  copy) NSString *scene_name;
@property (nonatomic, assign) NSInteger scene_status;


@end


@interface SceneModel : NSObject

@property (nonatomic, strong) NSArray<Scene *> *sceneList;

@end
