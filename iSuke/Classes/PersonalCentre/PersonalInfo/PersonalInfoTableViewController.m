//
//  PersonalInfoTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PersonalInfoTableViewController.h"
#import "RTAlertContrller.h"

@interface PersonalInfoTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PersonalInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




#pragma mark  ------UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *paAction = [UIAlertAction actionWithTitle:RTLocalizedString(iSuke_Photo_Album) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:^{
            }];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:RTLocalizedString(iSuke_Take_Photo) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //检测该设备是否支持拍摄
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                return;
            }
            
            UIImagePickerController *
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:RTLocalizedString(iSuke_Cancel) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:photoAction];
        [alertVC addAction:paAction];
        [alertVC addAction:cancleAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}




#pragma mark  ---UIImagePickerControllerDelegate--
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = nil;
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
