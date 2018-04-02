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



#define SB_DEVICECENTRE          @"DeviceCentre"
#define SB_DEVICEDETAIL          @"DeviceDetail"



#endif /* StoryboardID_h */
