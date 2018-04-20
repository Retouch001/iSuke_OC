//
//  WeekSelectTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/17.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "WeekSelectTableViewController.h"

static NSString *const identifier = @"cell";

@interface WeekSelectTableViewController ()

@property (nonatomic, strong) NSMutableArray *selectedWeeks;
@property (nonatomic, strong) NSArray *weeks;


@end

@implementation WeekSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)initData{
    self.weeks = @[RTLocalizedString(@"周一"),RTLocalizedString(@"周二"),RTLocalizedString(@"周三"),RTLocalizedString(@"周四"),RTLocalizedString(@"周五"),RTLocalizedString(@"周六"),RTLocalizedString(@"周日")];    
}


- (IBAction)leftBtnClick:(id)sender {
    [self.selectedWeeks sortUsingSelector:@selector(compare:)];
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < self.selectedWeeks.count; i++) {
        if (i == 0) {
            [string appendString:self.selectedWeeks[i]];
        }else{
            [string appendString:[NSString stringWithFormat:@",%@",self.selectedWeeks[i]]];
        }
    }
    self.block(string);
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -UITableViewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = self.weeks[indexPath.row];
    if ([_selectedWeeks containsObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]]) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic-check"]];
    }else{
        cell.accessoryView = [UIView new];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_selectedWeeks containsObject:[NSString stringWithFormat:@"%ld",indexPath.row + 1]]) {
        [self.selectedWeeks removeObject:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
    }else{
        [self.selectedWeeks addObject:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
    }
    [tableView reloadData];
}

@end
