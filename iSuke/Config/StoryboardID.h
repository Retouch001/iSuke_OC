//
//  StoryboardID.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#ifndef StoryboardID_h
#define StoryboardID_h


#define SB_INSTANCE(SB_ID)  [UIStoryboard storyboardWithName:SB_ID bundle:nil]

#define SB_VIEWCONTROLLER(SB_ID) [SB_INSTANCE(SB_ID) instantiateInitialViewController]

#define SB_VIEWCONTROLLER_IDENTIFIER(SB_ID,VC_ID)   [SB_INSTANCE(SB_ID) instantiateViewControllerWithIdentifier:VC_ID]


//设备
#define SB_DEVICE_CENTRE          @"DeviceCentre"
#define SB_DEVICE_DETAIL          @"DeviceDetail"
#define SB_DEVICE_CONFIG          @"DeviceConfig"

//场景
#define SB_SCENEMODE              @"SceneMode"

#define SB_SCENEMODE_ADD          @"addSceneMode"








#endif /* StoryboardID_h */
