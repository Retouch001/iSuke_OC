//
//  AppDelegate.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/14.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AppDelegate.h"
#import "RTNetworkConfig.h"
#import "RTUrlArgumentsFilter.h"
#import "MainUserManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    config.baseUrl = RT_DEVELOP_BASE_URL;
    config.debugLogEnabled = YES;

    MainUser *mainUser = [MainUserManager getLocalMainUserInfo];
    if (mainUser) {
        long timestamp = [NSDate date].timeIntervalSince1970;
        NSString *token = [[NSString stringWithFormat:@"%@%ldapp",mainUser.phone,timestamp] md5String];
        RTUrlArgumentsFilter *urlFilter = [RTUrlArgumentsFilter filterWithArguments:@{@"orgId": RT_ORGID,
                                                                @"phone" : mainUser.phone,
                                                                @"timestamp" : @(timestamp),
                                                                @"token" : token
                                                                }];
        [config addUrlFilter:urlFilter];
        UIViewController *mainVC = SB_VIEWCONTROLLER(SB_MAIN);
        self.window.rootViewController = mainVC;
    }else{
        UIViewController *mainVC = SB_VIEWCONTROLLER(SB_LOGIN_MODE);
        self.window.rootViewController = mainVC;
    }
    [self setAppWindows];
    [self configureSVProgressHUD];
    
    return YES;
}


- (void)configureSVProgressHUD{
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}


- (void)setAppWindows{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"ic_navigationBarBg"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBarTintColor:kColorTheme];
    
//    //隐藏导航栏下面的黑线
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //导航条上UIBarButtonItem颜色
    [[UINavigationBar appearance] setTintColor:UIColor.whiteColor];
    //TabBar选中图标的颜色,默认是蓝色
//    [[UITabBar appearance] setTintColor:UIColor.redColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:UIColor.whiteColor];
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
