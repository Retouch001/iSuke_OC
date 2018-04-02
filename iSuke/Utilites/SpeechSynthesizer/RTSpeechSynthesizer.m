//
//  RTSpeechSynthesizer.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/20.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTSpeechSynthesizer.h"
#import <AVFoundation/AVFoundation.h>

@interface RTSpeechSynthesizer()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;

@end



@implementation RTSpeechSynthesizer

+ (instancetype)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RTSpeechSynthesizer alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    if (self = [super init]){
        [self buildSpeechSynthesizer];
    }
    return self;
}

- (void)buildSpeechSynthesizer{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0){
        return;
    }
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynthesizer setDelegate:self];
}

- (void)speakString:(NSString *)string{
    if (self.speechSynthesizer){
        AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
        [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
        
        //iOS语音合成在iOS8及以下版本系统上语速异常
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0){
            aUtterance.rate = 0.25;//iOS7设置为0.25
        }else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0){
            aUtterance.rate = 0.15;//iOS8设置为0.15
        }
        
        if ([self.speechSynthesizer isSpeaking]){
            [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
        
        [self.speechSynthesizer speakUtterance:aUtterance];
    }
}

- (void)stopSpeak{
    if (self.speechSynthesizer){
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}


@end
