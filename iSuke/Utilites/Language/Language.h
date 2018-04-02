//
//  Language.h
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLang(key) [Language get:key alter:nil]
#define LanguageCode @[@"en", @"zh-Hans"]

@interface Language : NSObject

+ (void)initialize;
+ (void)setLanguage:(NSString *)language;
+ (NSString*)currentLanguageCode;
+ (void)userSelectedLanguage:(NSString *)selectedLanguage;
+ (NSString *)get:(NSString *)key alter:(NSString *)alternate;

@end
