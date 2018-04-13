//
//  SceneDetailTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneDetailTableViewController.h"
#import "TriggerCollectionViewCell.h"
#import "SceneModel.h"
#import "GetSceneConditionApi.h"
#import "AddSceneApi.h"
#import "SceneDetailApi.h"
#import "SceneCondition.h"
#import "EditSceneApi.h"


#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;

@interface SceneDetailTableViewController ()<RTRequestDelegate>{
    Scene *_scene;
    
    SceneDetailApi *sceneDetailApi;
    GetSceneConditionApi *getSceneConditionApi;
    AddSceneApi *addSceneApi;
    EditSceneApi *editSceneApi;
    
    NSArray *triggerTitleArray;
    NSArray *triggerIconArray;
}

@property (weak, nonatomic) IBOutlet UICollectionView *triggerCollectionView;
@property (weak, nonatomic) IBOutlet UIView *deviceCollectionView;

@end

@implementation SceneDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, 90);
    //flowLayout.minimumLineSpacing = 20;////最小行间距(默认为10)
    //flowLayout.minimumInteritemSpacing = 0;//最小item间距（默认为10
    flowLayout.sectionInset = UIEdgeInsetsMake(0 , 0, 0, 0);////设置senction的内边距
    //flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 5);
    
    self.triggerCollectionView.collectionViewLayout = flowLayout;
    [self.triggerCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TriggerCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    
//    getSceneConditionApi = [[GetSceneConditionApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
//    getSceneConditionApi.delegate = self;
//    [getSceneConditionApi start];
    
    
//    sceneDetailApi = [[SceneDetailApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene_id:_scene.scene_id];
//    sceneDetailApi.delegate = self;
//    [sceneDetailApi start];
    
//    editSceneApi = [[EditSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene_id:_scene.scene_id scene_status:1 scene_name:@"Hello" device_status:1 scene_city:@"北京" device_ids:@"11" condition_id:30 condition_option:@"日出" condition_sub_option:@""];
//    editSceneApi.delegate = self;
//    [editSceneApi start];
    
    
    
    triggerTitleArray = @[RTLocalizedString(@"温度"),RTLocalizedString(@"湿度"), RTLocalizedString(@"空气质量"), RTLocalizedString(@"PM2.5"), RTLocalizedString(@"天气"), RTLocalizedString(@"日出日落")];
    triggerIconArray = @[@"ic_temperature", @"ic_humidiity", @"ic_air", @"ic_pm", @"ic_weather", @"ic_sun"];
}


- (IBAction)rightBtnClick:(id)sender {
    SceneCondition *sceneCondition = [[SceneCondition alloc] init];
    sceneCondition.condition_id = 30;
    sceneCondition.condition_option = @[@"日出"];
    
    
    addSceneApi = [[AddSceneApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id scene_name:@"Retouch" device_status:0 scene_city:@"深圳" device_ids:@"3" condition_id:30 condition_option:@"日出" condition_sub_option:@""];
    addSceneApi.delegate = self;
    [addSceneApi start];
}





#pragma mark - UICollectionView Delegate  DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TriggerCollectionViewCell *cell = [TriggerCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    
    
    [cell freshCellWithIcon:triggerIconArray[indexPath.row] title:triggerTitleArray[indexPath.row]];
    
    return cell;
}




#pragma mark -RTRequestDelegate---
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end
