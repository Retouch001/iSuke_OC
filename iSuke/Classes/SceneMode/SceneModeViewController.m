//
//  SceneModeViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneModeViewController.h"
#import "DeviceCollectionViewCell.h"

#define ITEM_WIDTH1  (SCREEN_WIDTH - 3 * kMagin) / 2
static CGFloat kMagin = 10.f;


static NSString * const reuseIdentifier = @"Cell";


@interface SceneModeViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SceneModeViewController


#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH1, ITEM_WIDTH1-25);
    flowLayout.minimumLineSpacing = 10;////最小行间距(默认为10)
    //flowLayout.minimumInteritemSpacing = 0;//最小item间距（默认为10
    flowLayout.sectionInset = UIEdgeInsetsMake(kMagin + 10, kMagin, kMagin, kMagin);////设置senction的内边距
    //flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 5);
    
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DeviceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}






#pragma mark  -CollectionView Delegate-----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        [cell freshCellWihtIconString:@"ic_home" deviceName:@"回家模式"];
    }else if(indexPath.row == 1){
        [cell freshCellWihtIconString:@"ic_leave" deviceName:@"离家模式"];
    }else{
        [cell freshCellWihtIconString:@"ic_cup" deviceName:@"自定义模式-1"];
    }
    
    
    
    return cell;
}



@end
