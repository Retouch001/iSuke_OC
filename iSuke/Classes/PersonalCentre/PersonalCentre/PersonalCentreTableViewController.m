//
//  PersonalCentreTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "PersonalCentreTableViewController.h"
//#import "UINavigationBar+Awesome.h"

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
    self.tableView.separatorColor = self.tableView.backgroundColor;
    self.title = RTLocalizedString(@"个人中心");
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.tableView.tableHeaderView.height = 150;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshHeaderViewWith:[MainUserManager getLocalMainUserInfo]];
}


- (void)freshHeaderViewWith:(MainUser *)mainUser{
    _userName.text = mainUser.nickname;
    _phone.text = mainUser.phone;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值
//    if (yOffset < 0) {
//        CGFloat totalOffset = HEADER_HEIGHT + ABS(yOffset);
//        CGFloat f = totalOffset / (HEADER_HEIGHT);
//        self.headerBgImageView.frame =  CGRectMake(- (SCREEN_WIDTH * f - SCREEN_WIDTH) / 2, yOffset, SCREEN_WIDTH * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
//    }
//}





#pragma mark  ---UITableViewDelegate---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






@end
