//
//  MainUserManager.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainUser.h"

#define RT_MAINUSER_CACHE_KEY             @"RT_MainUser_Cache_Key"

@interface MainUserManager : NSObject

+ (instancetype)sharedInstance;

+ (void)updateLocalMainUserInfo:(MainUser *)mainUser;

+ (MainUser<NSCoding> *)getLocalMainUserInfo;

+ (void)clearMainUserInfo;

@end
