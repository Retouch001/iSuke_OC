//
//  DeviceTimingTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceTimingTableViewController.h"
#import "AddTimingTableViewController.h"
#import "UIScrollView+EmptyDataSet.h"

#import "DeviceCentreModel.h"
#import "GetTimedTaskApi.h"
#import "DeleteTimedTaskApi.h"
#import "EditTimedTaskApi.h"

#import "TimedTaskModel.h"
#import "TimedTaskTableViewCell.h"


@interface DeviceTimingTableViewController ()<RTRequestDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>{
    Device *_device;
    TimedTaskModel *timedTaskModel;
    
    GetTimedTaskApi *getTimedTaskApi;
    DeleteTimedTaskApi *deleteTimedTaskApi;
    EditTimedTaskApi *editTimedTaskApi;
}


@end

@implementation DeviceTimingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = UIColorHex(0xf1f0ef);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:RTLocalizedString(@"请稍后...")];
    getTimedTaskApi = [[GetTimedTaskApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id];
    getTimedTaskApi.delegate = self;
    [getTimedTaskApi start];
}

- (IBAction)addTimedTask:(id)sender {
    UINavigationController *nav = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_DETAIL, SB_EDIT_TIMEDTASK);
    AddTimingTableViewController *vc = nav.viewControllers.firstObject;
    vc.timedTaskVCType = RTTimedTaskVCTypeAdd;
    [vc setValue:_device forKey:@"_device"];
    
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return timedTaskModel.timedTaskList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimedTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TimedTask *timedTask = timedTaskModel.timedTaskList[indexPath.row];
    [cell freshCellWithTimedTask:timedTask];
    
    TimedTask *reTimedTask = [timedTask deepCopy];
    reTimedTask.timedtask_status = !reTimedTask.timedtask_status;
    @weakify(self);
    cell.switchClickBlock = ^{
        @strongify(self);
        self->editTimedTaskApi = [[EditTimedTaskApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id timedTask:reTimedTask];
        self->editTimedTaskApi.delegate = self;
        [self->editTimedTaskApi start];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TimedTask *timedTask = timedTaskModel.timedTaskList[indexPath.row];
    
    UINavigationController *nav = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_DETAIL, SB_EDIT_TIMEDTASK);
    AddTimingTableViewController *vc = nav.viewControllers.firstObject;
    vc.timedTaskVCType = RTTimedTaskVCTypeEdit;
    [vc setValue:timedTask forKey:@"_timedTask"];
    [vc setValue:_device forKey:@"_device"];

    [self presentViewController:nav animated:YES completion:nil];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [SVProgressHUD showWithStatus:RTLocalizedString(@"请稍后...")];
        self->deleteTimedTaskApi = [[DeleteTimedTaskApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id timedtask_id:self->timedTaskModel.timedTaskList[indexPath.row].timedtask_id];
        self->deleteTimedTaskApi.delegate = self;
        [self->deleteTimedTaskApi start];        
    }];
    deleteRowAction.backgroundColor = kColorDeleteBtnBg;
    return @[deleteRowAction];
}


#pragma mark -DZNEmptyDataSetDelegate--
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:RTLocalizedString(@"您还没有添加定时开启~")];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"ic_06nothing"];
}




#pragma mark --RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
        
    if ([request dataSuccess]) {
        timedTaskModel = [TimedTaskModel modelWithDictionary:request.responseObject];
        [self.tableView reloadData];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}




#pragma mark-Navigation------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nav = segue.destinationViewController;
    UIViewController *vc = nav.viewControllers.firstObject;
    [vc setValue:_device forKey:@"_device"];
}


@end
