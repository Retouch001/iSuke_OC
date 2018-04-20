//
//  ConfigDeviceFailView.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ConfigDeviceFailView.h"

@interface ConfigDeviceFailView ()
@property (nonatomic, copy) void (^cancelBlock)(void);                              // 取消回调
@property (nonatomic, copy) void (^okBlock)(void);

@property (nonatomic, strong) UIButton *bgBtn;
@end


@implementation ConfigDeviceFailView

- (void)showWithCancel:(void (^)(void))cancel ok:(void (^)(void))ok {
    self.cancelBlock = cancel;
    self.okBlock = ok;
    
    [self layoutIfNeeded];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgBtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.center.mas_equalTo(self.superview);
        make.centerX.mas_equalTo(self.superview);
        make.centerY.mas_equalTo(self.superview).offset(-20);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(230);
    }];
    [UIView animateWithDuration:.25f animations:^{
        self.bgBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        [self layoutIfNeeded];
    }];
    
}


- (IBAction)okBtnClick:(id)sender {
    !self.okBlock ? : self.okBlock();
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



@end
