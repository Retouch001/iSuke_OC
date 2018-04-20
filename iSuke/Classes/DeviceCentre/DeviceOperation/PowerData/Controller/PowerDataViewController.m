//
//  PowerDataViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PowerDataViewController.h"
#import "DeviceCentreModel.h"
#import "PowerTableViewCell.h"
#import "DevicePowerApi.h"
#import "PowerModel.h"

static NSString *const identifier = @"cell";

@interface PowerDataViewController ()<RTRequestDelegate,UITableViewDelegate>{
    Device *_device;
    PowerModel *powerModel;
    DevicePowerApi *devicePowerApi;
}

@property (weak, nonatomic) IBOutlet UILabel *todayPower;

@property (weak, nonatomic) IBOutlet UILabel *currentVoltage;
@property (weak, nonatomic) IBOutlet UILabel *currentElectricity;
@property (weak, nonatomic) IBOutlet UILabel *currentPower;
@property (weak, nonatomic) IBOutlet UILabel *totalPower;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PowerDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:kColorTheme];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PowerTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = kColorBase;
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    self.tableView.sectionIndexBackgroundColor = UIColor.redColor;
    
    [SVProgressHUD showWithStatus:RTLocalizedString(@"加载中...")];
    devicePowerApi = [[DevicePowerApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id];
    devicePowerApi.delegate = self;
    [devicePowerApi start];
}

- (void)freshUI{
    self.todayPower.text = [NSString stringWithFormat:@"%.2f",powerModel.powerGeneral.todayPower];
    self.currentVoltage.text = [NSString stringWithFormat:@"%.2f",powerModel.powerGeneral.currentVoltage];
    self.currentElectricity.text = [NSString stringWithFormat:@"%.2f",powerModel.powerGeneral.currentElectricity];
    self.currentPower.text = [NSString stringWithFormat:@"%.2f",powerModel.powerGeneral.currentPower];
    self.totalPower.text = [NSString stringWithFormat:@"%.2f",powerModel.powerGeneral.totalPower];
}


#pragma mark -UITableViewDelegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return powerModel.powerData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    PowerYear *powerYear = powerModel.powerData[section];
    return [NSString stringWithFormat:@"%@%@",powerYear.year,RTLocalizedString(@"年")];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = kColorBase;
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor colorWithHexString:@"0x9c9c9c"]];
    header.textLabel.font = [UIFont systemFontOfSize:15];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PowerYear *powerYear = powerModel.powerData[section];
    return powerYear.powerMonthList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PowerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    PowerYear *powerYear = powerModel.powerData[indexPath.section];
    PowerMonth *powerMoth = powerYear.powerMonthList[indexPath.row];
    [cell freshCellWithPowerMonth:powerMoth];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_DETAIL, SB_POWER_DETAIL);
    
    [vc setValue:_device forKey:@"_device"];
    [vc setValue:powerModel forKey:@"_powerModel"];
    [vc setValue:indexPath forKey:@"_indexPath"];
    
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request dataSuccess]) {
        powerModel = [PowerModel modelWithDictionary:request.responseObject];
        [self.tableView reloadData];
        [self freshUI];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end
