//
//  AppDelegate.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/14.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RootViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    config.baseUrl = RT_LINAG_BASE_URL;
    config.debugLogEnabled = YES;
    
    [self setRootViewController];
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
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:UIColor.whiteColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:UIColor.whiteColor];
}

//16进制字符串转data
- (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
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
