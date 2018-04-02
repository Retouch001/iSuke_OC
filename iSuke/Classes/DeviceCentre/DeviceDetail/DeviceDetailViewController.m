//
//  DeviceDetailViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "DeviceSocketTableViewCell.h"

static NSString *const identifier = @"Cell";

@interface DeviceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView *socketBackground;

@end

@implementation DeviceDetailViewController


#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.separatorColor = UIColor.clearColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DeviceSocketTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated{
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark --UITableViewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.backgroundColor = kColorBase;
    return cell;
}


@end
