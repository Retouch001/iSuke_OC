//
//  RootTableBarController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RootTableBarController.h"

@interface RootTableBarController ()

@end

@implementation RootTableBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 设置状态栏颜色
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


@end
