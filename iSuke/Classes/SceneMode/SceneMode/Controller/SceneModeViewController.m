//
//  SceneModeViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneModeViewController.h"
#import "SceneDetailTableViewController.h"
#import "SceneChangeTableViewController.h"

#import "UIScrollView+EmptyDataSet.h"
#import "SceneCollectionViewCell.h"

#import "GetScenesApi.h"
#import "DeleteSceneApi.h"

#import "SceneModel.h"

#define ITEM_WIDTH1  (SCREEN_WIDTH - 3 * kMagin) / 2
static NSString *const reuseIdentifier = @"cell";
static CGFloat kMagin = 10.f;

@interface SceneModeViewController ()<RTRequestDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>{
    SceneModel *sceneModel;
    
    GetScenesApi *getSceneApi;
    DeleteSceneApi *deleteSceneApi;
    
    BOOL editMode;
}
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;


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
    [kNotificationCenter addObserver:self selector:@selector(sceneCenterDidChanged:) name:RTSceneCenterDidChangeNotification object:nil];
}

- (void)sceneCenterDidChanged:(id)sender{
    [self loadDataFromNetwork];
}

- (void)dealloc{
    [kNotificationCenter removeObserver:self name:RTSceneCenterDidChangeNotification object:nil];
}


- (void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH1, ITEM_WIDTH1);
    flowLayout.minimumLineSpacing = 0;////最小行间距(默认为10)
    flowLayout.sectionInset = UIEdgeInsetsMake(kMagin + 10, kMagin, kMagin, kMagin);////设置senction的内边距
    self.collectionView.backgroundColor = kColorBase;
    //self.collectionView.allowsMultipleSelection = YES;
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
        for (Scene *scene in sceneModel.sceneList) {
            if (string.length > 0) {
                if (scene.selected) {
                    [string appendString:[NSString stringWithFormat:@",%ld",scene.scene_id]];
                }
            }else{
                if (scene.selected) {
                    [string appendString:[NSString stringWithFormat:@"%ld",scene.scene_id]];
                }
            }
        }
        deleteSceneApi = [[DeleteSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene_ids:string];
        deleteSceneApi.delegate = self;
        [deleteSceneApi start];
    }else{
        SceneChangeTableViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_SCENEMODE, SB_SCENMODE_CHANGE);
        vc.sceneChangeType = RTSceneChangeTypeAdd;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark  -CollectionView Delegate-----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sceneModel.sceneList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {    
    SceneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell freshCellWithScene:sceneModel.sceneList[indexPath.row] editMode:editMode];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (editMode) {
        Scene *scene = sceneModel.sceneList[indexPath.row];
        scene.selected = !scene.selected;
        [self.collectionView reloadData];
    }else{
        SceneDetailTableViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_SCENEMODE, SB_SCENEMODE_DETAIL);
        vc.title = sceneModel.sceneList[indexPath.row].scene_name;
        [vc setValue:sceneModel.sceneList[indexPath.row] forKey:@"_scene"];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    SceneChangeTableViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_SCENEMODE, SB_SCENMODE_CHANGE);
    vc.sceneChangeType = RTSceneChangeTypeAdd;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -30;
}



#pragma mark -RTRequestDelegate----
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
    if ([request isKindOfClass:[GetScenesApi class]]) {
        if ([request dataSuccess]) {
            sceneModel = [SceneModel modelWithDictionary:request.responseObject];
            [self.collectionView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }else{
        if ([request dataSuccess]) {
            [self loadDataFromNetwork];
        }else{
            [SVProgressHUD showErrorWithStatus:request.errorMessage];
        }
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
}
@end
