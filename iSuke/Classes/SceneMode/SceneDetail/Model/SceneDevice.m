//
//  SceneDevice.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneDevice.h"

@implementation SceneDevice

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

@end
