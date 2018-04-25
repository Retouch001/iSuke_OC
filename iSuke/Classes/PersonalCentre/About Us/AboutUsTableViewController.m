//
//  AboutUsTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AboutUsTableViewController.h"

@interface AboutUsTableViewController ()

@end

@implementation AboutUsTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
}


#pragma mark -UITableViewDelegate--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){
        [self goToSoftwareEvaluation];
    }else{
        [self goToWebsite];
    }
}


#pragma mark -PrivateMethod--
- (void)goToSoftwareEvaluation{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1142075299&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
}

- (void)goToWebsite{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ibreezee.net"]];
}

@end
