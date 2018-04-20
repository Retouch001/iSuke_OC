//
//  EditJackNameView.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditJackNameView : UIView

- (void)showWithCancel:(void(^)(void))cancel ok:(void(^)(NSString *number))ok;

@end
