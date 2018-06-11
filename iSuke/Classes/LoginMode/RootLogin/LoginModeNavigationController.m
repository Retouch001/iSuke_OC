//
//  LoginModeNavigationController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "LoginModeNavigationController.h"

@interface LoginModeNavigationController ()

@end

@implementation LoginModeNavigationController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 设置状态栏颜色
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
@end
