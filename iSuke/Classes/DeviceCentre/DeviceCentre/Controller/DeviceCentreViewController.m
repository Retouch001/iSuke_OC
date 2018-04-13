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
#import "UIScrollView+EmptyDataSet.h"

#import "DeviceCentreModel.h"

#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;


static NSString * const headIdentifier = @"headCell";

@interface DeviceCentreViewController ()<RTRequestDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>{
    DeviceManageApi *deviceManageApi;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) DeviceCentreModel *deviceCentreModel;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation DeviceCentreViewController
#pragma mark -LifeCycle------
- (void)viewDidLoad {
    [super viewDidLoad];
    deviceManageApi = [[DeviceManageApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
    deviceManageApi.delegate = self;
    
    [self initCollectionView];
    
    
    NSLog(@"%f----%f",self.headerView.height,HEADER_HEIGHT);
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.headerView.height = 20;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.headerView.height = 20;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerView.height = 20;
}


#pragma mark -Private Method--
- (void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH);
    //flowLayout.minimumLineSpacing = 20;////最小行间距(默认为10)
    //flowLayout.minimumInteritemSpacing = 0;//最小item间距（默认为10
    flowLayout.sectionInset = UIEdgeInsetsMake(0, kMagin, 20, kMagin);////设置senction的内边距
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DeviceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DeviceCentreCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    
    //self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromNetwork)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self loadDataFromNetwork];
}



- (void)loadDataFromNetwork{
    [deviceManageApi start];
}



#pragma mark  - IBAction -----
- (IBAction)leftBtnClick:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"编辑"]) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

- (IBAction)speechBtnClick:(id)sender {
    
}



#pragma mark  -CollectionView Delegate-----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.deviceCentreModel.deviceList.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //kind有两种 一种时header 一种事footer
    if (kind == UICollectionElementKindSectionHeader) {
        DeviceCentreCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
            header.title.text = @"我的设备";
        }else{
            header.title.text = @"共享的设备";
        }
        
        return header;
    }
    return nil;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DeviceCollectionViewCell *cell = [DeviceCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    
    Device *device = self.deviceCentreModel.deviceList[indexPath.row];
    [cell freshCellWithDevice:device cellType:RTCellTypeDeviceCentre];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = SB_VIEWCONTROLLER(SB_DEVICE_DETAIL);

    Device *device = self.deviceCentreModel.deviceList[indexPath.row];
    [vc setValue:device forKey:@"_device"];
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}



#pragma mark -DZNEmptyDataSetDelegate--
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
     return [[NSAttributedString alloc] initWithString:@"添加设备，开启智能生活"];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"ic_01nothing"];
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return [UIImage imageNamed:@"ic_addequipment1"];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    UIViewController *addDeviceVC = SB_VIEWCONTROLLER_IDENTIFIER(SB_DEVICE_CENTRE, SB_ADD_DEVICE);
    [self.navigationController pushViewController:addDeviceVC animated:YES];
}

//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityView startAnimating];
//    return activityView;
//}




#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [self.collectionView.mj_header endRefreshing];
    
    if ([request dataSuccess]) {
        self.deviceCentreModel = [DeviceCentreModel modelWithDictionary:request.responseObject];
        [self.collectionView reloadData];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [self.collectionView.mj_header endRefreshing];

}


@end
