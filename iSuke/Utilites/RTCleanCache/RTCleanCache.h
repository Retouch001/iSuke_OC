//
//  RTCleanCache.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^cleanCacheBlock)(void);

@interface RTCleanCache : NSObject

/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block;

/**
 *  整个缓存目录的大小
 */
+(float)folderSizeAtPath;

@end
