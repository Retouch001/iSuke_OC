//
//  RTVerifyCodeButton.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/4.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTVerifyCodeButton.h"
@interface RTVerifyCodeButton()

@property(strong,nonatomic) NSTimer *timer;
@property(assign,nonatomic) NSInteger count;

@end

@implementation RTVerifyCodeButton

#pragma mark - 初始化控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 配置
        [self setup];
        
    }
    
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}


#pragma mark - 配置
- (void)setup{
    self.enabled = YES;
    [self setTitle:RTLocalizedString(@"获取验证码") forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.backgroundColor = [UIColor  clearColor];
    [self setTitleColor:kColorTheme forState:UIControlStateNormal];
}


#pragma mark - 添加定时器
- (void)timeFailBeginFrom:(NSInteger)timeCount{
    [self setTitleColor:kColorUnClickBtnBg forState:UIControlStateNormal];
    self.count = timeCount;
    self.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark - 定时器事件
- (void)timeDown{
    if (self.count != 1){
        self.count -=1;
        self.enabled = NO;
        [self setTitle:[NSString stringWithFormat:@"剩余%ld秒", self.count] forState:UIControlStateNormal];
    } else {
        self.enabled = YES;
        [self setTitleColor:kColorTheme forState:UIControlStateNormal];
        [self setTitle:RTLocalizedString(@"获取验证码") forState:UIControlStateNormal];
        [self.timer invalidate];
    }
}

@end
