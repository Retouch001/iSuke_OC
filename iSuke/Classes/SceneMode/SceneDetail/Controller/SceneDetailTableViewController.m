//
//  SceneDetailTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneDetailTableViewController.h"

#import "TriggerCollectionViewCell.h"
#import "SceneDeviceCollectionViewCell.h"
#import "SelectSceneConditionView.h"

#import "SceneModel.h"
#import "SceneDetail.h"

#import "SceneDetailApi.h"
#import "EditSceneApi.h"


#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;

@interface SceneDetailTableViewController ()<RTRequestDelegate>{
    Scene *_scene;
    SceneDetail *_sceneDetail;
    
    SceneDetailApi *sceneDetailApi;
    EditSceneApi *editSceneApi;
    
    BOOL isEditMode;
}
@property (weak, nonatomic) IBOutlet UITextField *sceneName;
@property (weak, nonatomic) IBOutlet UILabel *sceneCity;
@property (weak, nonatomic) IBOutlet UILabel *sceneCondition;
@property (weak, nonatomic) IBOutlet UILabel *sceneDeviceStatus;
@property (weak, nonatomic) IBOutlet UIButton *sceneStatusBtn;

@property (nonatomic, strong) UICollectionViewFlowLayout *triggerLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *triggerCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *deviceLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *deviceCollectionView;

@property (nonatomic ,strong) SelectSceneConditionView *selectSceneConditionView;
@end

@implementation SceneDetailTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;

    self.triggerCollectionView.collectionViewLayout = self.triggerLayout;
    [self.triggerCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TriggerCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.deviceCollectionView.collectionViewLayout = self.deviceLayout;
    [self.deviceCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SceneDeviceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseDeviceIdentifier];
    
    [self.navigationItem.rightBarButtonItem setTitle:RTLocalizedString(@"编辑")];
    sceneDetailApi = [[SceneDetailApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene_id:_scene.scene_id];
    sceneDetailApi.delegate = self;
    [sceneDetailApi start];
}


#pragma mark -IBAction--
- (IBAction)rightBtnClick:(id)sender {
    if (isEditMode) {
        editSceneApi = [[EditSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene:_scene sceneDetail:_sceneDetail];
        editSceneApi.delegate = self;
        [editSceneApi start];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:RTLocalizedString(@"保存")];
        isEditMode = !isEditMode;
    }
}

- (void)freshUI{
    _sceneName.text = _scene.scene_name;
    _sceneCity.text = _sceneDetail.scene_city;
    if (_sceneDetail.sceneCondition.condition_sub_option.count > 0) {
        _sceneCondition.text = [NSString stringWithFormat:@"%@ %@%@",_sceneDetail.sceneCondition.condition_name,_sceneDetail.sceneCondition.condition_option.firstObject,_sceneDetail.sceneCondition.condition_sub_option.firstObject];
    }else{
        _sceneCondition.text = [NSString stringWithFormat:@"%@%@",_sceneDetail.sceneCondition.condition_name,_sceneDetail.sceneCondition.condition_option.firstObject];
    }
    _sceneDeviceStatus.text = _sceneDetail.device_status?RTLocalizedString(@"开启设备"):RTLocalizedString(@"关闭设备");
}


#pragma mark _UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 30;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 1) {
        return ITEM_WIDTH/2*3;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 3 && indexPath.row == 0) {
//        NSArray *array = @[RTLocalizedString(@"开启设备"),RTLocalizedString(@"关闭设备")];
//        [self.selectSceneConditionView showWithCancel:nil ok:^(NSString *number, NSString *subNumber) {
//
//        } option:array subOption:nil];
//    }
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
    if (isEditMode) {
        if ([collectionView isEqual:self.triggerCollectionView]) {
            SceneCondition *condition = _sceneDetail.sceneConditionList[indexPath.row];
            
            @weakify(self);
            [self.selectSceneConditionView showWithDataArray:condition.condition_option subDataArray:condition.condition_sub_option cancel:nil ok:^(NSArray *array) {
                @strongify(self);
                self->_sceneDetail.sceneCondition = condition;
                self->_sceneDetail.sceneCondition.condition_option = @[array.firstObject];
                if (array.count > 1) {
                    self->_sceneDetail.sceneCondition.condition_sub_option = @[array.lastObject];
                }
                [self freshUI];
                [self.triggerCollectionView reloadData];
            }];
        }else{
            SceneDevice *device = _sceneDetail.sceneDeviceList[indexPath.row];
            device.selected = !device.selected;
            [self.deviceCollectionView reloadData];
        }
    }
}


#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request isKindOfClass:[SceneDetailApi class]]) {
        if ([request dataSuccess]) {
            _sceneDetail = [SceneDetail modelWithDictionary:request.responseObject];
            [self.triggerCollectionView reloadData];
            [self.deviceCollectionView reloadData];
            [self freshUI];
        }
    }else{
        if (![request dataSuccess]) {
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
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
