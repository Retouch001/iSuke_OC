//
//  SettingTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SettingTableViewController.h"
#import "RTCleanCache.h"

@interface SettingTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *zoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;


@end

@implementation SettingTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    
    [self freshUI];
}

- (void)freshUI{
    self.phoneLabel.text = [MainUserManager getLocalMainUserInfo].phone;
    self.cacheLabel.text = [NSString stringWithFormat:@"%.1fM",[RTCleanCache folderSizeAtPath]];
}

#pragma mark -UITableViewDelegate--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3) {
        [self logout];
    }else if (indexPath.section == 2){
        [RTCleanCache cleanCache:^{
            [self freshUI];
            [SVProgressHUD showSuccessWithStatus:RTLocalizedString(@"缓存清理成功")];
        }];
    }
}


#pragma mark -PrivateMethod--
- (void)logout{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:RTLocalizedString(@"确定退出吗?") preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MainUserManager clearMainUserInfo];
        UIViewController *mainVC = SB_VIEWCONTROLLER(SB_LOGIN_MODE);
        kKeyWindow.rootViewController = mainVC;
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}



@end
