//
//  AddDeviceViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//


#import "AddDeviceViewController.h"
#import "AddDeviceCollectionViewCell.h"

static NSString *const reuseIdentifier = @"cell";

#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;

@interface AddDeviceViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AddDeviceViewController


#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH);
    flowLayout.minimumLineSpacing = 0;////最小行间距(默认为10)
    
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AddDeviceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}


#pragma mark  -CollectionView Delegate-----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddDeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell initCellUIWithIndexPath:indexPath];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = SB_VIEWCONTROLLER(SB_DEVICE_CONFIG);
    
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}



@end
