//
//  SceneChangeTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneChangeTableViewController.h"
#import "TriggerCollectionViewCell.h"
#import "SceneDeviceCollectionViewCell.h"
#import "SelectSceneConditionView.h"
#import "SelectCityTableViewController.h"

#import "GetSceneConditionApi.h"
#import "AddSceneApi.h"
#import "EditSceneApi.h"

#import "RTLocationManager.h"

#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;

@interface SceneChangeTableViewController ()<RTRequestDelegate>{
    GetSceneConditionApi *_getConidtionApi;
    AddSceneApi *_addSceneApi;
    EditSceneApi *_editSceneApi;
    
    Scene *_scene;
    SceneDetail *_sceneDetail;
    
    SceneDetail *_editSceneDetail;
}
@property (weak, nonatomic) IBOutlet UITextField *sceneNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *sceneCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneConditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneDeviceStatusLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *triggerCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *deviceCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *triggerLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *deviceLayout;
@property (nonatomic ,strong) SelectSceneConditionView *selectSceneConditionView;
@end

@implementation SceneChangeTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}


#pragma mark -PrivateMethod--
- (void)initUI{
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    self.triggerCollectionView.collectionViewLayout = self.triggerLayout;
    [self.triggerCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TriggerCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.deviceCollectionView.collectionViewLayout = self.deviceLayout;
    [self.deviceCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SceneDeviceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseDeviceIdentifier];
    [self.sceneNameTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)initData{
    if (_sceneChangeType == RTSceneChangeTypeAdd) {
        // 保存 Device 的现语言 (英语 法语 ，，，)
        NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        // 强制 成 简体中文
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans", nil] forKey:@"AppleLanguages"];

        [[RTLocationManager sharedManager] getCurrentGeolocationsCompled:^(NSArray<CLPlacemark *> *placemarks) {
            CLPlacemark *mark = placemarks.lastObject;
            self.sceneCityLabel.text = kStringIsEmpty(mark.locality)?mark.administrativeArea:mark.locality;
            NSLog(@"%f----%f", mark.location.coordinate.latitude, mark.location.coordinate.longitude);
        }];
        self.title = RTLocalizedString(@"添加场景");
        _getConidtionApi = [[GetSceneConditionApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
        _getConidtionApi.delegate = self;
        [_getConidtionApi start];
    }else{
        self.title = RTLocalizedString(@"编辑场景");
        _editSceneDetail = [_sceneDetail deepCopy];
        [self freshUI];
    }
}

- (void)freshUI{
    self.sceneNameTextField.text = _editSceneDetail.scene_name;
    self.sceneCityLabel.text = _editSceneDetail.scene_city;
    
    NSString *conditionName = _editSceneDetail.sceneCondition.condition_name;
    NSString *condition;
    if (_editSceneDetail.sceneCondition.condition_sub_option.count > 0) {
        condition = [NSString stringWithFormat:@"%@%@",_editSceneDetail.sceneCondition.condition_option.firstObject,_editSceneDetail.sceneCondition.condition_sub_option.firstObject];
    }else{
        condition = _editSceneDetail.sceneCondition.condition_option.firstObject;
    }
    
    NSString *sceneCondition = [NSString stringWithFormat:@"%@  %@",conditionName,condition];

    self.sceneConditionLabel.text = sceneCondition;
    self.sceneDeviceStatusLabel.text = _editSceneDetail.device_status?RTLocalizedString(@"开启设备"):RTLocalizedString(@"关闭设备");
}


#pragma mark - UITextFieldDidChanged---
- (void)textFieldDidChanged:(UITextField *)textField{
    _editSceneDetail.scene_name = textField.text;
}


#pragma mark -IBAction--
- (IBAction)leftBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rightBtnClick:(id)sender {
    if (self.sceneChangeType == RTSceneChangeTypeAdd) {
        NSString *string;
        if (kStringIsEmpty(_editSceneDetail.scene_name)) {
            string = RTLocalizedString(@"场景名不能为空");
        }else if (kStringIsEmpty(_editSceneDetail.scene_city)){
            string = RTLocalizedString(@"城市不能为空");
        }else if (!_editSceneDetail.sceneCondition){
            string = RTLocalizedString(@"触发条件不能为空");
        }else{
            BOOL existDevice = NO;
            for (SceneDevice *device in _editSceneDetail.sceneDeviceList) {
                if (device.selected) {
                    existDevice = YES;
                }
            }
            if (!existDevice) {
                string = RTLocalizedString(@"没有选择智能设备");
            }
        }
        if (string) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:string preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertVC animated:YES completion:nil];
        }else{
            _addSceneApi = [[AddSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id sceneDetail:_editSceneDetail];
            _addSceneApi.delegate = self;
            [_addSceneApi start];
        }
    }else{
        _editSceneApi = [[EditSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene:_scene sceneDetail:_editSceneDetail];
        _editSceneApi.delegate = self;
        [_editSceneApi start];
    }
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
    if (indexPath.section == 1) {
        SelectCityTableViewController *selectCityVC = [[SelectCityTableViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:selectCityVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else if (indexPath.section == 3 && indexPath.row == 0){
        NSArray *array = @[RTLocalizedString(@"开启设备"),RTLocalizedString(@"关闭设备")];
        [self.selectSceneConditionView showWithDataArray:array subDataArray:nil cancel:nil ok:^(NSArray *array) {
            if ([array.firstObject isEqualToString:RTLocalizedString(@"开启设备")]) {
                self->_editSceneDetail.device_status = YES;
            }else{
                self->_editSceneDetail.device_status = NO;
            }
            [self freshUI];
        }];
    }
}


#pragma mark - UICollectionView Delegate  DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.triggerCollectionView]) {
        return _editSceneDetail.sceneConditionList.count;
    }
    return _editSceneDetail.sceneDeviceList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.triggerCollectionView]) {
        TriggerCollectionViewCell *cell = [TriggerCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
        [cell freshCellWithSceneCodition:_editSceneDetail.sceneConditionList[indexPath.row] selectedCondition:_editSceneDetail.sceneCondition];
        return cell;
    }else{
        SceneDeviceCollectionViewCell *cell = [SceneDeviceCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
        [cell freshCellWithSceneDevice:_editSceneDetail.sceneDeviceList[indexPath.row]];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView isEqual:self.triggerCollectionView]) {
        SceneCondition *condition = _editSceneDetail.sceneConditionList[indexPath.row];
        @weakify(self);
        [self.selectSceneConditionView showWithDataArray:condition.condition_option subDataArray:condition.condition_sub_option cancel:nil ok:^(NSArray *array) {
            @strongify(self);
            self->_editSceneDetail.sceneCondition = [condition deepCopy];
            self->_editSceneDetail.sceneCondition.condition_option = @[array.firstObject];
            if (array.count > 1) {
                self->_editSceneDetail.sceneCondition.condition_sub_option = @[array.lastObject];
            }
            [self.triggerCollectionView reloadData];
            [self freshUI];
        }];
    }else{
        SceneDevice *device = _editSceneDetail.sceneDeviceList[indexPath.row];
        device.selected = !device.selected;
        [self.deviceCollectionView reloadData];
    }
}


#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request isKindOfClass:[GetSceneConditionApi class]]) {
        if ([request dataSuccess]) {
            _editSceneDetail = [SceneDetail modelWithDictionary:request.responseObject];
            _editSceneDetail.scene_city =  @"深圳市";
            [self.triggerCollectionView reloadData];
            [self.deviceCollectionView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else if([request isKindOfClass:[AddSceneApi class]]){
        if ([request dataSuccess]) {
            [kNotificationCenter postNotificationName:RTSceneCenterDidChangeNotification object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else{
        if ([request dataSuccess]) {
            _sceneDetail = _editSceneDetail;
            [kNotificationCenter postNotificationName:RTSceneDetailDidChangeNotification object:nil];
            [kNotificationCenter postNotificationName:RTSceneCenterDidChangeNotification object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


#pragma mark -GetterSetter--
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
