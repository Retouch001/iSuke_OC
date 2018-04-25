//
//  SceneModeViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneModeViewController.h"
#import "SceneDetailTableViewController.h"
#import "UIScrollView+EmptyDataSet.h"

#import "SceneCollectionViewCell.h"

#import "GetScenesApi.h"
#import "SceneModel.h"
#import "DeleteSceneApi.h"


static NSString *const reuseIdentifier = @"cell";

#define ITEM_WIDTH1  (SCREEN_WIDTH - 3 * kMagin) / 2
static CGFloat kMagin = 20.f;

@interface SceneModeViewController ()<RTRequestDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>{
    SceneModel *sceneModel;
    
    GetScenesApi *getSceneApi;
    DeleteSceneApi *deleteSceneApi;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end



@implementation SceneModeViewController
#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    getSceneApi = [[GetScenesApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
    getSceneApi.delegate = self;
    
    [self initCollectionView];
    
    self.topViewConstraint.constant = HEADER_HEIGHT;
    self.navigationController.navigationBarHidden = YES;
    if (IPHONE_X) {
        self.navigationViewConstraint.constant = 88;
    }else{
        self.navigationViewConstraint.constant = 64;
    }

}

- (void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH1, ITEM_WIDTH1);
    flowLayout.minimumLineSpacing = kMagin;////最小行间距(默认为10)
    flowLayout.sectionInset = UIEdgeInsetsMake(kMagin + 10, kMagin, kMagin, kMagin);////设置senction的内边距
    self.collectionView.backgroundColor = kColorBase;
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SceneCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromNetwork)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self loadDataFromNetwork];
}

- (void)loadDataFromNetwork{
    [getSceneApi start];
}

- (IBAction)leftBtnClick:(id)sender {
}



#pragma mark  -CollectionView Delegate-----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sceneModel.sceneList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {    
    SceneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell freshCellWithScene:sceneModel.sceneList[indexPath.row]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SceneDetailTableViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_SCENEMODE, SB_SCENEMODE_DETAIL);
    vc.title = sceneModel.sceneList[indexPath.row].scene_name;
    [vc setValue:sceneModel.sceneList[indexPath.row] forKey:@"_scene"];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -DZNEmptyDataSetDelegate--
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:RTLocalizedString(@"添加智能场景，享受智能生活")];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"ic_05nothing"];
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return [UIImage imageNamed:@"ic_addequipment1"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    UIViewController *addDeviceVC = SB_VIEWCONTROLLER_IDENTIFIER(SB_SCENEMODE, SB_SCENMODE_ADD);
    [self.navigationController pushViewController:addDeviceVC animated:YES];
}




#pragma mark -RTRequestDelegate----
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [self.collectionView.mj_header endRefreshing];
    if ([request dataSuccess]) {
        sceneModel = [SceneModel modelWithDictionary:request.responseObject];
        [self.collectionView reloadData];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [self.collectionView.mj_header endRefreshing];

}




@end
