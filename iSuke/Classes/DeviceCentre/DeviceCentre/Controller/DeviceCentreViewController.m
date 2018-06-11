//
//  DeviceCentreViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "DeviceCentreViewController.h"
#import "DeviceCollectionViewCell.h"
#import "DeviceCentreCollectionReusableView.h"
#import "DeviceManageApi.h"
#import "DeleteDeviceApi.h"
#import "UIScrollView+EmptyDataSet.h"

#import "DeviceCentreModel.h"
#import "RTUdpSocketManager.h"
#import "SpeechView.h"

#define ITEM_WIDTH  SCREEN_WIDTH / 3
static NSString * const headIdentifier = @"headCell";

@interface DeviceCentreViewController ()<RTRequestDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>{
    DeviceManageApi *deviceManageApi;
    DeleteDeviceApi *deleteDeviceApi;
    
    NSInteger    _contentInsetTop;
    BOOL editMode;
    NSMutableArray *selectedDeviceArray;
    
    BOOL firstLoad;
}

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (nonatomic, strong) DeviceCentreModel *deviceCentreModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationBarConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speakBtnConstraint;

@property (nonatomic ,strong) SpeechView *speechView;
@property (nonatomic, strong) NSArray *devices;
@end


@implementation DeviceCentreViewController
#pragma mark -LifeCycle------
- (void)viewDidLoad {
    [super viewDidLoad];
    deviceManageApi = [[DeviceManageApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
    deviceManageApi.delegate = self;
    _contentInsetTop = HEADER_HEIGHT;
    [self initCollectionView];
    self.headerHeightConstraint.constant = _contentInsetTop;
    self.navigationController.navigationBarHidden = YES;
    if (IPHONE_X) {
        self.navigationBarConstraint.constant = 88;
        self.speakBtnConstraint.constant = self.speakBtnConstraint.constant + 44;
    }else{
        self.navigationBarConstraint.constant = 64;
        self.speakBtnConstraint.constant = self.speakBtnConstraint.constant + 32;
    }
    [kNotificationCenter addObserver:self selector:@selector(deviceCenterDidChanged:) name:RTDeviceCenterDidChangeNotification object:nil];
    selectedDeviceArray = [NSMutableArray array];
    
    firstLoad = YES;
}

- (void)dealloc{
    [kNotificationCenter removeObserver:self name:RTShareUserDidChangeNotification object:nil];
}


#pragma mark -Private Method--
- (void)deviceCenterDidChanged:(id)notification{
    [self loadDataFromNetwork];
}

- (void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH);
    flowLayout.minimumLineSpacing = 0;////最小行间距(默认为10)
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);////设置senction的内边距
    
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
    self.collectionView.backgroundColor = kColorBase;
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DeviceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DeviceCentreCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromNetwork)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    [self loadDataFromNetwork];
}

- (void)loadDataFromNetwork{
    self.devices = [NSArray array];
    [deviceManageApi start];
}

- (NSArray *)deviceGroupWithDevices:(NSArray *)devices{
    NSMutableArray *totalArray = [NSMutableArray array];
    NSMutableArray *ownArray = [NSMutableArray array];
    NSMutableArray *shareArray = [NSMutableArray array];
    for (Device *device in devices) {
        if (device.device_belong_type == RTDeviceBelongTypeOwn) {
            [ownArray addObject:device];
        }else{
            [shareArray addObject:device];
        }
    }
    if (ownArray.count > 0) {
        [totalArray addObject:ownArray];
    }
    if (shareArray.count > 0) {
        [totalArray addObject:shareArray];
    }
    return totalArray;
}

#pragma mark  - IBAction -----
- (IBAction)leftBtnClick:(id)sender {
    if (editMode) {
        [self.leftBtn setTitle:RTLocalizedString(@"编辑") forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"" forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"ic_addhome"] forState:UIControlStateNormal];
    }else{
        [self.leftBtn setTitle:RTLocalizedString(@"退出编辑") forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage new] forState:UIControlStateNormal];
        [self.rightBtn setTitle:RTLocalizedString(@"删除") forState:UIControlStateNormal];
    }
    editMode = !editMode;
    [self.collectionView reloadData];
}

- (IBAction)rightBtnClick:(id)sender {
    if (editMode) {
        editMode = !editMode;
        [self.leftBtn setTitle:RTLocalizedString(@"编辑") forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"" forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"ic_addhome"] forState:UIControlStateNormal];
        [self.collectionView reloadData];
        
        [SVProgressHUD showWithStatus:RTLocalizedString(@"正在执行...")];
        NSMutableString *string = [NSMutableString string];
        for (Device *device in selectedDeviceArray) {
            if (string.length > 0) {
                [string appendString:[NSString stringWithFormat:@",%ld@%ld",device.device_id,device.device_user_id]];
            }else{
                [string appendString:[NSString stringWithFormat:@"%ld@%ld",device.device_id,device.device_user_id]];
            }
        }
        deleteDeviceApi = [[DeleteDeviceApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id deviceId_userId:string];
        deleteDeviceApi.delegate = self;
        [deleteDeviceApi start];
    }else{
        id vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_CENTRE, SB_ADD_DEVICE);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)speechBtnClick:(id)sender {
    [kKeyWindow addSubview:self.speechView];
    [self.speechView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(kKeyWindow);
    }];
}


#pragma mark  -CollectionView Delegate-----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.devices.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.devices[section];
    return array.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        DeviceCentreCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
        Device *device = self.devices[indexPath.section][indexPath.row];
        if (device.device_belong_type == RTDeviceBelongTypeOwn) {
            header.title.text = RTLocalizedString(@"我的设备");
        }else{
            header.title.text = RTLocalizedString(@"共享的设备");
        }
        return header;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DeviceCollectionViewCell *cell = [DeviceCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    Device *device = self.devices[indexPath.section][indexPath.row];
    [cell freshCellWithDevice:device editMode:editMode];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (editMode) {
        Device *device = self.devices[indexPath.section][indexPath.row];
        device.selected = !device.selected;
        if (device.selected) {
            [selectedDeviceArray addObject:device];
        }else{
            if ([selectedDeviceArray containsObject:device]) {
                [selectedDeviceArray removeObject:device];
            }
        }
        [self.collectionView reloadData];
    }else{
        UIViewController *vc = SB_VIEWCONTROLLER(SB_DEVICE_DETAIL);
        Device *device = self.devices[indexPath.section][indexPath.row];
        [vc setValue:device forKey:@"_device"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark -DZNEmptyDataSetDelegate--
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (deviceManageApi.responseStatusCode == 0) {
        return [[NSAttributedString alloc] initWithString:RTLocalizedString(@"网路未连接")];
    }
    return [[NSAttributedString alloc] initWithString:RTLocalizedString(@"添加设备，开启智能生活")];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (deviceManageApi.responseStatusCode == 0) {
        return [UIImage imageNamed:@"ic_03nothing"];
    }
    return [UIImage imageNamed:@"ic_01nothing"];
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (deviceManageApi.responseStatusCode == 0) {
        return nil;
    }
    return [UIImage imageNamed:@"ic_addequipment1"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (deviceManageApi.responseStatusCode == 0) {
        return [[NSAttributedString alloc] initWithString:RTLocalizedString(@"点击重试")];
    }
    return nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (deviceManageApi.responseStatusCode == 0) {
        [self loadDataFromNetwork];
    }else{
        UIViewController *addDeviceVC = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_CENTRE, SB_ADD_DEVICE);
        [self.navigationController pushViewController:addDeviceVC animated:YES];
    }
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    if (firstLoad) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        return activityView;
    }
    return nil;
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
    firstLoad = NO;
    if ([request dataSuccess]) {
        self.deviceCentreModel = [DeviceCentreModel modelWithDictionary:request.responseObject];
        self.devices = [self deviceGroupWithDevices:self.deviceCentreModel.deviceList];
        [self.collectionView reloadData];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    firstLoad = NO;
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView reloadData];
}


#pragma mark -SetterGetter--
- (SpeechView *)speechView{
    if (!_speechView) {
        _speechView = [SpeechView createFromXib];
    }
    return _speechView;
}

@end
