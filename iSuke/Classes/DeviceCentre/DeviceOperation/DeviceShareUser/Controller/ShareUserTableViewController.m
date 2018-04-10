//
//  ShareUserTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ShareUserTableViewController.h"
#import "DeviceShareUserApi.h"
#import "DeviceCentreModel.h"

@interface ShareUserTableViewController ()<RTRequestDelegate>{
    Device *device;
    
    DeviceShareUserApi *deviceShareUserApi;
}

@end

@implementation ShareUserTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    deviceShareUserApi = [[DeviceShareUserApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:device.device_id];
    deviceShareUserApi.delegate = self;
    [deviceShareUserApi start];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了删除");
    }];
    deleteRowAction.backgroundColor = kColorDeleteBtnBg;
    //置顶
    UITableViewRowAction *remarkAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"备注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了备注");
    }];
    remarkAction.backgroundColor = kColorTheme;
    

    return @[deleteRowAction,remarkAction];
}




#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end
