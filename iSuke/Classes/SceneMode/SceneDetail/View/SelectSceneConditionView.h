//
//  SelectSceneConditionView.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/20.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectSceneConditionView : UIView

- (void)showWithDataArray:(NSArray *)dataArray subDataArray:(NSArray *)subDataArray cancel:(void(^)(void))cancel ok:(void(^)(NSArray *array))ok;

@end
