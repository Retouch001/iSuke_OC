//
//  SpeechView.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/25.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SpeechView.h"

static NSString *const identifier = @"cell";
@interface SpeechView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *speechBtn;

@end

@implementation SpeechView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self configTableView];
}


- (IBAction)speechBtnClick:(id)sender {
    
}

- (IBAction)closeBtnClick:(id)sender {
    [self removeFromSuperview];
}


#pragma mark -UITableViewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.clearColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.text = @"识别中...";
    cell.detailTextLabel.textColor = UIColor.whiteColor;
    cell.detailTextLabel.text = @"我在听，请讲...";
    return cell;
}


- (void)configTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = UIColor.clearColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}


@end
