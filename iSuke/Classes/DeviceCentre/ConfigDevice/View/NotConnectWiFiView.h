//
//  NotConnectWiFiView.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/18.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotConnectWiFiView : UIView

- (void)showWithCancel:(void(^)(void))cancel ok:(void(^)(void))ok;


@end
