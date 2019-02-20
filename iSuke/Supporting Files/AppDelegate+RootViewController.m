//
//  AppDelegate+RootViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AppDelegate+RootViewController.h"
#import "RTAddinterceptor.h"

@implementation AppDelegate (RootViewController)

- (void)setRootViewController{
    //MainUser *mainUser = [MainUserManager getLocalMainUserInfo];
    
    MainUser *mainUser = [MainUser new];
    mainUser.app_user_id = 123;
    mainUser.nickname = @"Retouch";
    mainUser.phone = @"15179182756";
    [MainUserManager updateLocalMainUserInfo:mainUser];
    
    if (YES) {
        [RTAddinterceptor addInterceptorWithMainUser:mainUser];
        UIViewController *mainVC = SB_VIEWCONTROLLER(SB_MAIN);
        self.window.rootViewController = mainVC;
    }else{
        UIViewController *mainVC = SB_VIEWCONTROLLER(SB_LOGIN_MODE);
        
        self.window.rootViewController = mainVC;
    }
}
@end
