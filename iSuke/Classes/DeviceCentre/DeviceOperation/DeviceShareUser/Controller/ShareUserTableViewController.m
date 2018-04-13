//
//  ShareUserTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ShareUserTableViewController.h"
#import "ShareUserTableViewCell.h"

#import "DeviceShareUserApi.h"
#import "UnshareApi.h"
#import "SetShareUserAliasApi.h"


#import "DeviceCentreModel.h"
#import "ShareUserModel.h"


@interface ShareUserTableViewController ()<RTRequestDelegate>{
    Device *_device;
    ShareUserModel *shareUserModel;
    
    
    DeviceShareUserApi *deviceShareUserApi;
    UnshareApi *unShareApi;
    SetShareUserAliasApi *setAliasApi;
    
    ShareUser *tempShareUser;
}


@end

@implementation ShareUserTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    deviceShareUserApi = [[DeviceShareUserApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id];
    deviceShareUserApi.delegate = self;
    [deviceShareUserApi start];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return shareUserModel.shareUserList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell freshCellWithShareUser:shareUserModel.shareUserList[indexPath.row]];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        self->unShareApi = [[UnshareApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:self->_device.device_id share_user_id:self->shareUserModel.shareUserList[indexPath.row].share_user_id];
        self->tempShareUser = self->shareUserModel.shareUserList[indexPath.row];
        self->unShareApi.delegate = self;
        [self->unShareApi start];
        
        NSLog(@"点击了删除");
    }];
    deleteRowAction.backgroundColor = kColorDeleteBtnBg;
    //置顶
    UITableViewRowAction *remarkAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"备注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        self->setAliasApi = [[SetShareUserAliasApi alloc] initWitApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id share_user_id:self->shareUserModel.shareUserList[indexPath.row].share_user_id share_user_alias:@"共享用户别名"];
        self->tempShareUser = self->shareUserModel.shareUserList[indexPath.row];
        self -> setAliasApi.delegate = self;
        [self->setAliasApi start];
        
        NSLog(@"点击了备注");
    }];
    remarkAction.backgroundColor = kColorTheme;
    

    return @[deleteRowAction,remarkAction];
}




#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    
    if ([request isKindOfClass:[DeviceShareUserApi class]]) {
        if ([request dataSuccess]) {
            shareUserModel = [ShareUserModel modelWithDictionary:request.responseObject];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else if([request isKindOfClass:[UnshareApi class]]){
        if ([request dataSuccess]) {
            [shareUserModel.shareUserList removeObject:tempShareUser];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else{
        if ([request dataSuccess]) {
            tempShareUser.friend_alias = @"共享用户别名";
            [self.tableView reloadData];
        }

    }

}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


#pragma mark --Navigation--
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = segue.destinationViewController;
    [vc setValue:_device forKey:@"_device"];
}


@end
