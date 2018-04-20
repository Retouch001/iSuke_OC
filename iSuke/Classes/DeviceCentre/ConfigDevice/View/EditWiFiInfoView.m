//
//  EditWiFiInfoView.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/18.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "EditWiFiInfoView.h"
#import <SystemConfiguration/CaptiveNetwork.h>


@interface EditWiFiInfoView ()

@property (nonatomic, copy) void (^cancelBlock)(void);                              // 取消回调
@property (nonatomic, copy) void (^okBlock)(NSString *wifiName, NSString *wifiPsd);                       // 确定回调
@property (weak, nonatomic) IBOutlet UITextField *wifiNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *wifiPsdTextField;



@property (nonatomic, strong) UIButton *bgBtn;

@end

@implementation EditWiFiInfoView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _wifiNameTextField.text = [self fetchSSIDInfo][@"SSID"];
}


- (void)showWithCancel:(void (^)(void))cancel ok:(void (^)(NSString *wifiName, NSString *wifiPsd))ok {
    self.cancelBlock = cancel;
    self.okBlock = ok;
    
    [self layoutIfNeeded];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgBtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.superview);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(260);
    }];
    [UIView animateWithDuration:.25f animations:^{
        self.bgBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        [self layoutIfNeeded];
    }];
    
}


- (IBAction)okBtnClick:(id)sender {
    !self.okBlock ? : self.okBlock(self.wifiNameTextField.text,self.wifiPsdTextField.text);
    [self removeFromSuperview];
    [self.bgBtn removeFromSuperview];
}

- (IBAction)cancelBtnClick:(id)sender {
    !self.cancelBlock ? : self.cancelBlock();
    [self removeFromSuperview];
    [self.bgBtn removeFromSuperview];
}


- (UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.frame = [UIScreen mainScreen].bounds;
    }
    return _bgBtn;
}

- (NSDictionary *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}



@end
