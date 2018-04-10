//
//  MainUserManager.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "MainUserManager.h"


@implementation MainUserManager

+ (instancetype)sharedInstance{
    static MainUserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MainUserManager alloc] init];
    });
    return sharedInstance;
}


+ (void)updateLocalMainUserInfo:(MainUser *)mainUser{
    YYCache *cache = [YYCache cacheWithName:RT_MAINUSER_CACHE_NAME];
    [cache.diskCache setObject:mainUser forKey:RT_MAINUSER_CACHE_KEY];
}


+ (MainUser *)getLocalMainUserInfo{
    YYCache *cache = [YYCache cacheWithName:RT_MAINUSER_CACHE_NAME];
    MainUser *mainUser = (MainUser *)[cache.diskCache objectForKey:RT_MAINUSER_CACHE_KEY];
    return mainUser;
}


+ (void)clearMainUserInfo{
    YYCache *cache = [YYCache cacheWithName:RT_MAINUSER_CACHE_NAME];
    [cache.diskCache removeObjectForKey:RT_MAINUSER_CACHE_KEY];
}




@end
