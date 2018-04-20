//
//  AddDeviceCollectionViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/18.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddDeviceCollectionViewCell.h"

@interface AddDeviceCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *nameArray;

@end

@implementation AddDeviceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconArray = @[@"ic_socket",@"ic_turnon",@"ic_light",@"ic_others"];
    self.nameArray = @[RTLocalizedString(@"插座"), RTLocalizedString(@"开关"), RTLocalizedString(@"照明"), RTLocalizedString(@"其他设备")];
}


- (void)initCellUIWithIndexPath:(NSIndexPath *)indexPath{
    _icon.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    _name.text = self.nameArray[indexPath.row];
}

@end
