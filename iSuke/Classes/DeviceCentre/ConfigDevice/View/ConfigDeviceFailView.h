//
//  ConfigDeviceFailView.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigDeviceFailView : UIView

- (void)showWithCancel:(void (^)(void))cancel ok:(void (^)(void))ok;

@end
