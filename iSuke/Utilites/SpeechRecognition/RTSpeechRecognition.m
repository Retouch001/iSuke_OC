//
//  RTSpeechRecognition.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/20.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTSpeechRecognition.h"
#import <Speech/Speech.h>

@interface RTSpeechRecognition()<SFSpeechRecognizerDelegate>

@property (strong, nonatomic)SFSpeechRecognitionTask *recognitionTask; //语音识别任务
@property (strong, nonatomic)SFSpeechRecognizer *speechRecognizer; //语音识别器
@property (strong, nonatomic)SFSpeechAudioBufferRecognitionRequest *recognitionRequest; //识别请求
@property (strong, nonatomic)AVAudioEngine *audioEngine; //录音引擎

@property (strong,nonatomic)NSString * lastString;//用来记录上一句


@end


@implementation RTSpeechRecognition

+ (instancetype)sharedHelper{
    static RTSpeechRecognition *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    if (self = [super init]){
        
        //获取权限
        if (@available(iOS 10.0, *)) {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                switch (status) {
                    case SFSpeechRecognizerAuthorizationStatusAuthorized:
                        NSLog(@"可以语音识别");
                        break;
                    case SFSpeechRecognizerAuthorizationStatusDenied:
                        NSLog(@"用户被拒绝访问语音识别");
                        if(self.errorHandler){
                            self.errorHandler(self, TSSpeechHelperErrorTypeUserRefuse);
                        }
                        break;
                    case SFSpeechRecognizerAuthorizationStatusRestricted:
                        NSLog(@"不能在该设备上进行语音识别");
                        if(self.errorHandler){
                            self.errorHandler(self, TSSpeechHelperErrorTypeNoNotPossible);
                        }
                        break;
                    case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                        NSLog(@"没有授权语音识别");
                        if(self.errorHandler){
                            self.errorHandler(self, TSSpeechHelperErrorTypeNoPermission);
                        }
                        break;
                    default:
                        break;
                }
            }];
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}

#pragma mark - Public
//停止录音
- (void)stopRecording{
    [self.recognitionRequest endAudio];
}

//开始录音
-(void)startRecording{
    if (self.recognitionTask) {
        [self.recognitionTask cancel];
        self.recognitionTask = nil;
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bool  audioBool = [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    bool  audioBool1= [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
    bool  audioBool2= [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    if (audioBool || audioBool1||  audioBool2) {
        //可以使用
    }else{
        //这里说明有的功能不支持,提示不支持语音功能
        if (self.errorHandler) {
            self.errorHandler(self, TSSpeechHelperErrorTypeNoNotPossible);//提示设备不支持的错误
        }
        return;
    }
    if (@available(iOS 10.0, *)) {
        self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
    } else {
        // Fallback on earlier versions
    }
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    self.recognitionRequest.shouldReportPartialResults = true;
    
    //开始识别任务
    if (@available(iOS 10.0, *)) {
        self.recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
            bool isFinal = false;
            if (result) {
                
                NSString * bestString = [[result bestTranscription] formattedString];
                isFinal = [result isFinal];
                
                if(self.sentenceSpeechHandler){
                    if(self.lastString && self.lastString.length>0){
                        //获取最后一句话
                        NSRange range = [bestString rangeOfString:self.lastString];
                        NSString * nowString = [bestString substringFromIndex:range.length];
                        self.sentenceSpeechHandler(self, nowString);
                        NSLog(@"当前识别内容是: %@",nowString);
                    }else{
                        self.sentenceSpeechHandler(self, bestString);
                    }
                }
                
                if (self.allSpeechHandler) {
                    self.allSpeechHandler(self, [bestString copy]);
                }
                
                self.lastString = bestString;
                NSLog(@"进行了一次语音识别,内容是: %@",bestString);
            }
            if (error || isFinal) {
                [self.audioEngine stop];
                [inputNode removeTapOnBus:0];
                self.recognitionRequest = nil;
                self.recognitionTask = nil;
                //self.siriBtu.enabled = true;
            }
        }];
    } else {
        // Fallback on earlier versions
    }
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self.recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    [self.audioEngine prepare];
    bool audioEngineBool = [self.audioEngine startAndReturnError:nil];
    if (!audioEngineBool) {
        //打开录音失败
        if (self.errorHandler) {
            self.errorHandler(self, TSSpeechHelperErrorTypeAudioStartError);
        }
    }
}

#pragma mark - Delegate
-(void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (self.stateHandler) {
        self.stateHandler(self, available);
    }
}


#pragma mark - Lazy
- (SFSpeechRecognizer *)speechRecognizer{
    if (_speechRecognizer == nil){
        NSLocale *cale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-CN"];//英语就是 en_US
        if (@available(iOS 10.0, *)) {
            _speechRecognizer = [[SFSpeechRecognizer alloc]initWithLocale:cale];
        } else {
            // Fallback on earlier versions
        }
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

- (AVAudioEngine *)audioEngine{
    if (_audioEngine == nil) {
        _audioEngine = [[AVAudioEngine alloc]init];
    }
    return _audioEngine;
}



@end
