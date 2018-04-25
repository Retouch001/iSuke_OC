//
//  FAQViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "FAQViewController.h"
#import "FAQApi.h"

@interface FAQViewController ()<RTRequestDelegate>{
    FAQApi *faqApi;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation FAQViewController
#pragma mark -LifeCycel--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    faqApi = [[FAQApi alloc] init];
    faqApi.delegate = self;
    [faqApi start];
}

#pragma mark -UIWebViewDelegate--
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:RTLocalizedString(@"正在加载...")];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:RTLocalizedString(@"加载出错")];
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.responseObject[@"url"]]]];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


@end
