//
//  AppDelegate.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/14.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setAppWindows];
    
    return YES;
}


- (void)setAppWindows{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//再plist文件中设置View controller-based status bar appearance 为 NO才能起效
    
    
    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
//
//    //导航条上标题的颜色
//    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
//
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"ic_navigationBarBg"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    //导航条上UIBarButtonItem颜色
    [[UINavigationBar appearance] setTintColor:UIColor.blackColor];
    //TabBar选中图标的颜色,默认是蓝色
//    [[UITabBar appearance] setTintColor:UIColor.redColor];
    
//    [[UITabBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTranslucent:YES];
//    [[UINavigationBar appearance] setBarTintColor:kColorTableViewCell];
//
//    //TabBar的背景颜色
//    [[UITabBar appearance] setBarTintColor:kColorTabbar];
//
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor2692E1}forState:UIControlStateSelected];
//
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorThirdText}forState:UIControlStateNormal];
    
    
    
    
//    if (@available(iOS 11.0, *)) {// 如果iOS 11走else的代码，系统自己的文字和箭头会出来
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
//
//        UIImage *backButtonImage = [[UIImage imageNamed:@"ic_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//        [UINavigationBar appearance].backIndicatorImage = backButtonImage;
//
//        [UINavigationBar appearance].backIndicatorTransitionMaskImage =backButtonImage;
//    }else{
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
//
//        UIImage *image = [[UIImage imageNamed:@"ic_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//
//        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    }
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
