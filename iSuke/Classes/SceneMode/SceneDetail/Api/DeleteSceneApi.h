//
//  DeleteSceneApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface DeleteSceneApi : RTBaseRequest

- (id)initWithApp_user_id:(NSInteger)app_user_id scene_ids:(NSString *)scene_ids;

@end
