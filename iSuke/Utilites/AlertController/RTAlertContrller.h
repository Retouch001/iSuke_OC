//
//  RTAlertContrller.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTAlertContrller : NSObject

+ (void)alertFromVC:(UIViewController *)viewController
         alertTitle:(NSString *)alertTitle
      defaultTtitle:(NSString *)defaultTtitle
     defaultHandler:(void(^)(void))defaultHandler;


+ (void)alertFromVC:(UIViewController *)viewController
         alertTitle:(NSString *)alertTitle
        cancelTitle:(NSString *)cancelTitle
   destructiveTitle:(NSString *)destructiveTitle
      cancelHandler:(void(^)(void))cancelHandler
 destructiveHandler:(void(^)(void))destructiveHandler;


+ (void)alertFromVC:(UIViewController *)viewController
         alertTitle:(NSString *)alertTitle
       alertMessage:(NSString *)alertMessage
        cancelTitle:(NSString *)cancelTitle
   destructiveTitle:(NSString *)destructiveTitle
      cancelHandler:(void(^)(void))cancelHandler
 destructiveHandler:(void(^)(void))destructiveHandler;


@end
