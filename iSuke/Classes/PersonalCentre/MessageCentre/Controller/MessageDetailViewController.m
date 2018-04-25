//
//  MessageDetailViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailApi.h"
#import "MessageModel.h"

@interface MessageDetailViewController ()<RTRequestDelegate>{
    Message *_message;
    
    MessageDetailApi *messageDetailApi;
}
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    messageDetailApi = [[MessageDetailApi alloc] initWithMessageId:_message.message_id];
    messageDetailApi.delegate = self;
    [messageDetailApi start];
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        //_contentTextView.text = request.responseObject[@"messageDetail"];
        _contentTextView.attributedText = [[NSAttributedString alloc] initWithString:request.responseObject[@"messageDetail"]];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}



@end
