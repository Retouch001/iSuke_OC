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

#define ITEM_WIDTH  (SCREEN_WIDTH - 4 * kMagin) / 3
static CGFloat kMagin = 10.f;


static NSString * const headIdentifier = @"headCell";

@interface DeviceCentreViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation DeviceCentreViewController


#pragma mark -LifeCycle------
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.navigationController.navigationBarHidden = YES;
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
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
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
    
    if (indexPath.row == 0) {
        [cell freshCellWithIcon:@"ic_light" deviceName:@"客厅灯" cellType:RTCellTypeDeviceCentre];
    }else if(indexPath.row == 1){
        [cell freshCellWithIcon:@"ic_socket" deviceName:@"插座" cellType:RTCellTypeDeviceCentre];
    }else{
        [cell freshCellWithIcon:@"ic_light" deviceName:@"客厅灯-2" cellType:RTCellTypeDeviceCentre];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = SB_VIEWCONTROLLER(SB_DEVICE_DETAIL);

    [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
}




@end
