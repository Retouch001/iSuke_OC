//
//  MessageCentreTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "MessageCentreTableViewController.h"
#import "MessageCentreTableViewCell.h"
#import "GetMessagesApi.h"

#import "MessageModel.h"

static NSString *const reuseIdentifier = @"cell";

@interface MessageCentreTableViewController ()<RTRequestDelegate>{
    GetMessagesApi *getMessagesApi;
    
    MessageModel *messageModel;
}

@end

@implementation MessageCentreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageCentreTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    getMessagesApi = [[GetMessagesApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id];
    getMessagesApi.delegate = self;
    [getMessagesApi start];
    
}





#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messageModel.messageList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCentreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell freshCellWithMessage:messageModel.messageList[indexPath.row]];
    
    return cell;
}



#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        messageModel = [MessageModel modelWithDictionary:request.responseObject];
        [self.tableView reloadData];
    }
    
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end