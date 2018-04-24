//
//  AddSceneApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"
#import "SceneDetail.h"

@interface AddSceneApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id sceneDetail:(SceneDetail *)sceneDetail;

@end
