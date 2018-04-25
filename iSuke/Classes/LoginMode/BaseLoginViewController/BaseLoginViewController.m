//
//  BaseLoginViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "BaseLoginViewController.h"

@interface BaseLoginViewController ()

@end

@implementation BaseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    self.navigationController.navigationBar.tintColor = UIColor.blackColor;
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
