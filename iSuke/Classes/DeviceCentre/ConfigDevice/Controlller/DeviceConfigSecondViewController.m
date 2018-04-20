//
//  DeviceConfigSecondViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/18.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceConfigSecondViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>


@interface DeviceConfigSecondViewController ()

@end

@implementation DeviceConfigSecondViewController

#pragma mark -LifeCycel--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}


- (void)applicationBecomeActive{
    NSString *connectedSSID = [self fetchSSIDInfo][@"SSID"];
    if ([connectedSSID isEqualToString:@"isuke"] ) {
        self.block();
        [self.navigationController popViewControllerAnimated:NO];
    }
}


#pragma mark -IBAction--
- (IBAction)nextAction:(id)sender {
    [self toWIFI];
}


-(void)toWIFI {
    NSURL *url1 = [NSURL URLWithString:@"App-Prefs:root=INTERNET_TETHERING"];
    // iOS10也可以使用url2访问，不过使用url1更好一些，可具体根据业务需求自行选择
    //NSURL *url2 = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (@available(iOS 11.0, *)) {
        [[UIApplication sharedApplication] openURL:url1 options:@{} completionHandler:nil];
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:url1]){
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url1 options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url1];
            }
        }
    }
}


- (NSDictionary *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}


@end
