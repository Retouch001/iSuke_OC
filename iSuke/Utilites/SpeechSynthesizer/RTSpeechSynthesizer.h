//
//  RTSpeechSynthesizer.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/20.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTSpeechSynthesizer : NSObject

+ (instancetype)sharedInstance;

- (void)speakString:(NSString *)string;

- (void)stopSpeak;

@end
