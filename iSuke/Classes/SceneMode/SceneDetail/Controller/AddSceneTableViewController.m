//
//  AddSceneTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/23.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddSceneTableViewController.h"
#import "TriggerCollectionViewCell.h"
#import "SceneDeviceCollectionViewCell.h"
#import "SelectSceneConditionView.h"

#import "GetSceneConditionApi.h"
#import "AddSceneApi.h"


#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;

@interface AddSceneTableViewController ()<RTRequestDelegate>{
    GetSceneConditionApi *getConidtionApi;
    AddSceneApi *addSceneApi;
    
    SceneDetail *_sceneDetail;
}
@property (weak, nonatomic) IBOutlet UITextField *sceneNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *sceneCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneConditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneDeviceStatusLabel;


@property (nonatomic, strong) UICollectionViewFlowLayout *triggerLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *triggerCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *deviceLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *deviceCollectionView;
@property (nonatomic ,strong) SelectSceneConditionView *selectSceneConditionView;

@end

@implementation AddSceneTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    
    self.triggerCollectionView.collectionViewLayout = self.triggerLayout;
    [self.triggerCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TriggerCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.deviceCollectionView.collectionViewLayout = self.deviceLayout;
    [self.deviceCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SceneDeviceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseDeviceIdentifier];
    
    [_sceneNameTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    getConidtionApi = [[GetSceneConditionApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
    getConidtionApi.delegate = self;
    [getConidtionApi start];
    
}


#pragma mark -IBAction--
- (IBAction)rightBtnClick:(id)sender {
    addSceneApi = [[AddSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id sceneDetail:_sceneDetail];
    addSceneApi.delegate = self;
    [addSceneApi start];
}


#pragma mark - UITextFieldDidChanged---
- (void)textFieldDidChanged:(UITextField *)textField{
    _sceneDetail.scene_name = textField.text;
}


#pragma mark _UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 1) {
        return ITEM_WIDTH/2*3;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3 && indexPath.row == 0) {
        NSArray *array = @[RTLocalizedString(@"开启设备"),RTLocalizedString(@"关闭设备")];
        [self.selectSceneConditionView showWithDataArray:array subDataArray:nil cancel:nil ok:^(NSArray *array) {
            if ([array.firstObject isEqualToString:RTLocalizedString(@"开启设备")]) {
                self->_sceneDetail.device_status = 1;
            }else{
                self->_sceneDetail.device_status = 0;
            }
            [self freshUI];
        }];
    }
}


#pragma mark - UICollectionView Delegate  DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.triggerCollectionView]) {
        return _sceneDetail.sceneConditionList.count;
    }
    return _sceneDetail.sceneDeviceList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.triggerCollectionView]) {
        TriggerCollectionViewCell *cell = [TriggerCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
        [cell freshCellWithSceneCodition:_sceneDetail.sceneConditionList[indexPath.row] selectedCondition:_sceneDetail.sceneCondition];
        return cell;
    }else{
        SceneDeviceCollectionViewCell *cell = [SceneDeviceCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
        [cell freshCellWithSceneDevice:_sceneDetail.sceneDeviceList[indexPath.row]];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView isEqual:self.triggerCollectionView]) {
        SceneCondition *condition = _sceneDetail.sceneConditionList[indexPath.row];
        @weakify(self);
        [self.selectSceneConditionView showWithDataArray:condition.condition_option subDataArray:condition.condition_sub_option cancel:nil ok:^(NSArray *array) {
            @strongify(self);
            self->_sceneDetail.sceneCondition = [condition deepCopy];
            self->_sceneDetail.sceneCondition.condition_option = @[array.firstObject];
            if (array.count > 1) {
                self->_sceneDetail.sceneCondition.condition_sub_option = @[array.lastObject];
            }
            [self.triggerCollectionView reloadData];
            [self freshUI];
        }];
    }else{
        SceneDevice *device = _sceneDetail.sceneDeviceList[indexPath.row];
        device.selected = !device.selected;
        [self.deviceCollectionView reloadData];
    }
}


#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request isKindOfClass:[GetSceneConditionApi class]]) {
        if ([request dataSuccess]) {
            _sceneDetail = [SceneDetail modelWithDictionary:request.responseObject];
            _sceneDetail.scene_city = _sceneCityLabel.text;
            [self.triggerCollectionView reloadData];
            [self.deviceCollectionView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else{
        if (![request dataSuccess]) {
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


#pragma mark -PrivateMethod--
- (void)freshUI{
    _sceneCityLabel.text = _sceneDetail.scene_name;
    _sceneCityLabel.text = _sceneDetail.scene_city;
    if (_sceneDetail.sceneCondition.condition_sub_option.count > 0) {
        _sceneConditionLabel.text = [NSString stringWithFormat:@"%@%@%@",_sceneDetail.sceneCondition.condition_name,_sceneDetail.sceneCondition.condition_option.firstObject,_sceneDetail.sceneCondition.condition_sub_option.firstObject];
    }else{
        _sceneConditionLabel.text = [NSString stringWithFormat:@"%@%@",_sceneDetail.sceneCondition.condition_name,_sceneDetail.sceneCondition.condition_option.firstObject];
    }
    _sceneDeviceStatusLabel.text = _sceneDetail.device_status?RTLocalizedString(@"开启设备"):RTLocalizedString(@"关闭设备");
}



#pragma mark -SetterGetter--
- (UICollectionViewFlowLayout *)triggerLayout{
    if (!_triggerLayout) {
        _triggerLayout = [[UICollectionViewFlowLayout alloc] init];
        [_triggerLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _triggerLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH/4*3);
        _triggerLayout.minimumLineSpacing = 0;////最小行间距(默认为10)
        _triggerLayout.sectionInset = UIEdgeInsetsMake(0 , 0, 0, 0);////设置senction的内边距
    }
    return _triggerLayout;
}

- (UICollectionViewFlowLayout *)deviceLayout{
    if (!_deviceLayout) {
        _deviceLayout = [[UICollectionViewFlowLayout alloc] init];
        [_deviceLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _deviceLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH/2);
        _deviceLayout.minimumLineSpacing = 15;////最小行间距(默认为10)
        _deviceLayout.sectionInset = UIEdgeInsetsMake(10 , 10, 10, 10);////设置senction的内边距
    }
    return _deviceLayout;
}

- (SelectSceneConditionView *)selectSceneConditionView{
    if (!_selectSceneConditionView) {
        _selectSceneConditionView = [SelectSceneConditionView createFromXib];
    }
    return _selectSceneConditionView;
}


@end
