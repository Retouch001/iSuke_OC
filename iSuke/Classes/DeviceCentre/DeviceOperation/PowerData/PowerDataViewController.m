//
//  PowerDataViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PowerDataViewController.h"


static NSString *const identifier = @"cell";

@interface PowerDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *todayPower;

@property (weak, nonatomic) IBOutlet UILabel *currentVoltage;
@property (weak, nonatomic) IBOutlet UILabel *currentElectricty;
@property (weak, nonatomic) IBOutlet UILabel *currentPower;
@property (weak, nonatomic) IBOutlet UILabel *totalPower;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PowerDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.tableFooterView = [UIView new];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}



@end
