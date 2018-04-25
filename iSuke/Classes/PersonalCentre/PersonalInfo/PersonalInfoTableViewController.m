//
//  PersonalInfoTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PersonalInfoTableViewController.h"
#import "RTAlertContrller.h"
#import "ModifyUserIconApi.h"

@interface PersonalInfoTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,RTRequestDelegate>{
    ModifyUserIconApi *modifyUserIconApi;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation PersonalInfoTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = self.tableView.backgroundColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshUI];
}


#pragma mark -PrivateMethod--
- (void)freshUI{
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",config.baseUrl,RT_ICON_BASE,[MainUserManager getLocalMainUserInfo].avatar]];
    [self.iconImageView setImageWithURL:url placeholder:[UIImage imageNamed:RTPORTRAIT]];
    self.nameLabel.text = [MainUserManager getLocalMainUserInfo].nickname;
    self.phoneLabel.text = [MainUserManager getLocalMainUserInfo].phone;
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
            [self presentViewController:imagePicker animated:YES completion:nil];
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
    modifyUserIconApi = [[ModifyUserIconApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id icon:image];
    modifyUserIconApi.delegate = self;
    [modifyUserIconApi start];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        MainUser *user = [MainUserManager getLocalMainUserInfo];
        user.avatar = request.responseObject[@"fileName"];
        [MainUserManager updateLocalMainUserInfo:user];
        [self freshUI];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}

@end
