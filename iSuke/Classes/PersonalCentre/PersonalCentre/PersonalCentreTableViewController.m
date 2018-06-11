//
//  PersonalCentreTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PersonalCentreTableViewController.h"

#define PERSONAL_HEAD_HEIGHT (SCREEN_HEIGHT/5.5)

@interface PersonalCentreTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerBgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *phone;



@end

@implementation PersonalCentreTableViewController
#pragma mark ---LifeCycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    self.tableView.tableHeaderView.height = PERSONAL_HEAD_HEIGHT;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshHeaderViewWith:[MainUserManager getLocalMainUserInfo]];
}

- (void)freshHeaderViewWith:(MainUser *)mainUser{
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",config.baseUrl,RT_ICON_BASE,[MainUserManager getLocalMainUserInfo].avatar]];
    [self.icon setImageWithURL:url placeholder:[UIImage imageNamed:RTPORTRAIT]];
    _userName.text = kStringIsEmpty(mainUser.nickname)?RTLocalizedString(@"未设置昵称"):mainUser.nickname;
    _phone.text = mainUser.phone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值
    if (yOffset < 0) {
        CGFloat totalOffset = PERSONAL_HEAD_HEIGHT + ABS(yOffset);
        CGFloat f = totalOffset / PERSONAL_HEAD_HEIGHT;
        self.headerBgImageView.frame =  CGRectMake(- (SCREEN_WIDTH * f - SCREEN_WIDTH) / 2, yOffset, SCREEN_WIDTH * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
    }
}


#pragma mark  ---UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
