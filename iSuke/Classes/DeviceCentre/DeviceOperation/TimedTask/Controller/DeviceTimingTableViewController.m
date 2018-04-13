//
//  DeviceTimingTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceTimingTableViewController.h"
#import "DeviceCentreModel.h"
#import "GetTimedTaskApi.h"
#import "DeleteTimedTaskApi.h"
#import "TimedTaskModel.h"
#import "TimedTaskTableViewCell.h"

@interface DeviceTimingTableViewController ()<RTRequestDelegate>{
    Device *_device;
    TimedTaskModel *timedTaskModel;
    
    GetTimedTaskApi *getTimedTaskApi;
    DeleteTimedTaskApi *deleteTimedTaskApi;
}


@end

@implementation DeviceTimingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = UIColorHex(0xf1f0ef);
    
    getTimedTaskApi = [[GetTimedTaskApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id];
    getTimedTaskApi.delegate = self;
    [getTimedTaskApi start];
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
    [cell freshCellWithTimedTask:timedTaskModel.timedTaskList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TimedTask *timedTask = timedTaskModel.timedTaskList[indexPath.row];
    
    UINavigationController *nav = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_DETAIL, SB_EDIT_TIMEDTASK);
    UIViewController *vc = nav.viewControllers.firstObject;
    [vc setValue:timedTask forKey:@"_timedTask"];
    vc.title = RTLocalizedString(@"编辑");
    
    [self presentViewController:nav animated:YES completion:nil];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        self->deleteTimedTaskApi = [[DeleteTimedTaskApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id timedtask_id:self->timedTaskModel.timedTaskList[indexPath.row].timedtask_id];
        self->deleteTimedTaskApi.delegate = self;
        [self->deleteTimedTaskApi start];
        
        NSLog(@"点击了删除");
    }];
    deleteRowAction.backgroundColor = kColorDeleteBtnBg;
    return @[deleteRowAction];
}






#pragma mark --RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
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
