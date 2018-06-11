//
//  SceneDetailTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneDetailTableViewController.h"
#import "SceneChangeTableViewController.h"

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
    
    SceneDetail *_editSceneDetail;
    
    SceneDetailApi *sceneDetailApi;
    EditSceneApi *_editSceneApi;
}
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
    
    [kNotificationCenter addObserver:self selector:@selector(sceneDetailDidChanged:) name:RTSceneDetailDidChangeNotification object:nil];
    [self loadDataFromNetwork];
}

- (void)dealloc{
    [kNotificationCenter removeObserver:self name:RTSceneDetailDidChangeNotification object:nil];
}


#pragma mark -IBAction--
- (IBAction)rightBtnClick:(id)sender {
    SceneChangeTableViewController *addDeviceVC = SB_VIEWCONTROLLER_IDENTIFIER(SB_SCENEMODE, SB_SCENMODE_CHANGE);
    addDeviceVC.sceneChangeType = RTSceneChangeTypeEdit;
    [addDeviceVC setValue:_scene forKey:@"_scene"];
    [addDeviceVC setValue:_sceneDetail forKey:@"_sceneDetail"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addDeviceVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)sceneStatusBtnClick:(id)sender {
    _editSceneDetail = [_sceneDetail deepCopy];
    _editSceneDetail.scene_status = !_editSceneDetail.scene_status;
    [SVProgressHUD showWithStatus:RTLocalizedString(@"正在加载...")];
    _editSceneApi = [[EditSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene:_scene sceneDetail:_editSceneDetail];
    _editSceneApi.delegate = self;
    [_editSceneApi start];
}


#pragma mark -PrivateMethod--
- (void)loadDataFromNetwork{
    [SVProgressHUD showWithStatus:RTLocalizedString(@"正在加载...")];
    sceneDetailApi = [[SceneDetailApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene_id:_scene.scene_id];
    sceneDetailApi.delegate = self;
    [sceneDetailApi start];
}

- (void)freshUI{
    self.title = _sceneDetail.scene_name;
    self.sceneCity.text = _sceneDetail.scene_city;
    if (_sceneDetail.sceneCondition.condition_sub_option.count > 0) {
        self.sceneCondition.text = [NSString stringWithFormat:@"%@ %@%@",_sceneDetail.sceneCondition.condition_name,_sceneDetail.sceneCondition.condition_option.firstObject,_sceneDetail.sceneCondition.condition_sub_option.firstObject];
    }else{
        self.sceneCondition.text = [NSString stringWithFormat:@"%@%@",_sceneDetail.sceneCondition.condition_name,_sceneDetail.sceneCondition.condition_option.firstObject];
    }
    self.sceneDeviceStatus.text = _sceneDetail.device_status?RTLocalizedString(@"开启设备"):RTLocalizedString(@"关闭设备");
}

- (void)freshSceneStatusBtnUI{
    if (_sceneDetail.scene_status) {
        [self.sceneStatusBtn setTitle:[NSString stringWithFormat:@"%@%@",RTLocalizedString(@"关闭"),_sceneDetail.scene_name] forState:UIControlStateNormal];
        self.sceneStatusBtn.backgroundColor = UIColor.whiteColor;
        [self.sceneStatusBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
        self.sceneStatusBtn.layer.borderColor = kColorTheme.CGColor;
    }else{
        [self.sceneStatusBtn setTitle:[NSString stringWithFormat:@"%@%@",RTLocalizedString(@"打开"),_sceneDetail.scene_name] forState:UIControlStateNormal];
        self.sceneStatusBtn.backgroundColor = kColorTheme;
        [self.sceneStatusBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.sceneStatusBtn.layer.borderColor = UIColor.clearColor.CGColor;
    }
}


- (void)sceneDetailDidChanged:(id)sender{
    [self loadDataFromNetwork];
}


#pragma mark _UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 30;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        return ITEM_WIDTH/2*3;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
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



#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request isKindOfClass:[SceneDetailApi class]]) {
        if ([request dataSuccess]) {
            _sceneDetail = [SceneDetail modelWithDictionary:request.responseObject];
            [self.triggerCollectionView reloadData];
            [self.deviceCollectionView reloadData];
            [self freshUI];
            [self freshSceneStatusBtnUI];
        }
    }else{
        if ([request dataSuccess]) {
            [kNotificationCenter postNotificationName:RTSceneCenterDidChangeNotification object:nil];
            _sceneDetail = _editSceneDetail;
            [self freshSceneStatusBtnUI];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
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
