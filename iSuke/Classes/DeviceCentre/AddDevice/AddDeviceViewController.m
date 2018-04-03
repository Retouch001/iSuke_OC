//
//  AddDeviceViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//


#import "AddDeviceViewController.h"
#import "DeviceCollectionViewCell.h"

#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;

@interface AddDeviceViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AddDeviceViewController


#pragma mark  --LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH);
    //flowLayout.minimumLineSpacing = 20;////最小行间距(默认为10)
    //flowLayout.minimumInteritemSpacing = 0;//最小item间距（默认为10
    flowLayout.sectionInset = UIEdgeInsetsMake(kMagin , kMagin, kMagin, kMagin);////设置senction的内边距
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
    
    DeviceCollectionViewCell *cell = [DeviceCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        [cell freshCellWithIcon:@"ic_light" deviceName:@"客厅灯" cellType:RTCellTypeDeviceAdd];
    }else if(indexPath.row == 1){
        [cell freshCellWithIcon:@"ic_socket" deviceName:@"插座" cellType:RTCellTypeDeviceAdd];
    }else{
        [cell freshCellWithIcon:@"ic_light" deviceName:@"客厅灯-2" cellType:RTCellTypeDeviceAdd];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = SB_VIEWCONTROLLER(SB_DEVICE_CONFIG);
    
    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}



@end
