//
//  ShareUserTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ShareUserTableViewController.h"
#import "ShareUserTableViewCell.h"
#import "EditJackNameView.h"
#import "UIScrollView+EmptyDataSet.h"

#import "DeviceShareUserApi.h"
#import "UnshareApi.h"
#import "SetShareUserAliasApi.h"


#import "DeviceCentreModel.h"
#import "ShareUserModel.h"


@interface ShareUserTableViewController ()<RTRequestDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>{
    Device *_device;
    ShareUserModel *shareUserModel;
    
    DeviceShareUserApi *deviceShareUserApi;
    UnshareApi *unShareApi;
    SetShareUserAliasApi *setAliasApi;
    
    ShareUser *tempShareUser;
    
    EditJackNameView *editRemarkView;
    NSString *tempRemark;
}
@end

@implementation ShareUserTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    self.tableView.tableFooterView = [UIView new];
    [kNotificationCenter addObserver:self selector:@selector(shareUserDidChanged:) name:RTShareUserDidChangeNotification object:nil];
    deviceShareUserApi = [[DeviceShareUserApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:_device.device_id];
    deviceShareUserApi.delegate = self;
    [deviceShareUserApi start];
}

- (void)dealloc{
    [kNotificationCenter removeObserver:self name:RTShareUserDidChangeNotification object:nil];
}


#pragma mark -PrivateMethod--
- (void)shareUserDidChanged:(id)notification{
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
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:RTLocalizedString(@"删除") handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        self->unShareApi = [[UnshareApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device_id:self->_device.device_id share_user_id:self->shareUserModel.shareUserList[indexPath.row].share_user_id];
        self->tempShareUser = self->shareUserModel.shareUserList[indexPath.row];
        self->unShareApi.delegate = self;
        [self->unShareApi start];
    }];
    deleteRowAction.backgroundColor = kColorDeleteBtnBg;
    //备注
    UITableViewRowAction *remarkAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:RTLocalizedString(@"备注") handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        self->editRemarkView = [EditJackNameView createFromXib];
        [self->editRemarkView showWithCancel:nil ok:^(NSString *number) {
            [SVProgressHUD showWithStatus:RTLocalizedString(@"正在执行...")];
            self->setAliasApi = [[SetShareUserAliasApi alloc] initWitApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id share_user_id:self->shareUserModel.shareUserList[indexPath.row].share_user_id share_user_alias:number];
            self->tempShareUser = self->shareUserModel.shareUserList[indexPath.row];
            self->tempRemark = number;
            self -> setAliasApi.delegate = self;
            [self->setAliasApi start];
        }];
        
    }];
    remarkAction.backgroundColor = kColorTheme;
    return @[deleteRowAction,remarkAction];
}


#pragma mark -DZNEmptyDataSetDelegate--
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:RTLocalizedString(@"没有共享设备给好友~")];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"ic_04nothing"];
}



#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
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
            tempShareUser.friend_alias = tempRemark;
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
