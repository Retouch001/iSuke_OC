//
//  SceneModeViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneModeViewController.h"
#import "SceneCollectionViewCell.h"
#import "GetScenesApi.h"
#import "SceneModel.h"
#import "DeleteSceneApi.h"


static NSString *const reuseIdentifier = @"cell";

#define ITEM_WIDTH1  (SCREEN_WIDTH - 3 * kMagin) / 2
static CGFloat kMagin = 20.f;

@interface SceneModeViewController ()<RTRequestDelegate>{
    SceneModel *sceneModel;
    
    GetScenesApi *getSceneApi;
    DeleteSceneApi *deleteSceneApi;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end



@implementation SceneModeViewController
#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH1, ITEM_WIDTH1-25);
    flowLayout.minimumLineSpacing = kMagin;////最小行间距(默认为10)
    //flowLayout.minimumInteritemSpacing = 0;//最小item间距（默认为10
    flowLayout.sectionInset = UIEdgeInsetsMake(kMagin + 10, kMagin, kMagin, kMagin);////设置senction的内边距
    //flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 5);
    
    self.collectionView.backgroundColor = kColorBase;
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SceneCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    getSceneApi = [[GetScenesApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
    getSceneApi.delegate = self;
    [getSceneApi start];
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
    UIViewController *vc = SB_VIEWCONTROLLER_IDENTIFIER(SB_SCENEMODE, SB_SCENEMODE_ADD);
    
    Scene *scene = sceneModel.sceneList[indexPath.row];
    
    vc.title = sceneModel.sceneList[indexPath.row].scene_name;
    [vc setValue:sceneModel.sceneList[indexPath.row] forKey:@"_scene"];
    
//    deleteSceneApi = [[DeleteSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene_ids:[NSString stringWithFormat:@"%ld",(long)scene.scene_id]];
//    deleteSceneApi.delegate = self;
//    [deleteSceneApi start];
    
    
    //[self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}




#pragma mark -RTRequestDelegate----
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        sceneModel = [SceneModel modelWithDictionary:request.responseObject];
        [self.collectionView reloadData];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end
