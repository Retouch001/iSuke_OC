//
//  AddSceneModeTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/3.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddSceneModeTableViewController.h"
#import "TriggerCollectionViewCell.h"

#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;


@interface AddSceneModeTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *triggerTitleArray;
    NSArray *triggerIconArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *triggerCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *deviceCollectionView;





@end

@implementation AddSceneModeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.separatorColor = self.tableView.backgroundColor;
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
    
    
    triggerTitleArray = @[RTLocalizedString(@"温度"),RTLocalizedString(@"湿度"), RTLocalizedString(@"空气质量"), RTLocalizedString(@"PM2.5"), RTLocalizedString(@"天气"), RTLocalizedString(@"日出日落")];
    triggerIconArray = @[@"ic_temperature", @"ic_humidiity", @"ic_air", @"ic_pm", @"ic_weather", @"ic_sun"];
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





#pragma mark - Table view data source



@end
