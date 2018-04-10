//
//  MainUser.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "MainUser.h"

@implementation MainUser

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self modelEncodeWithCoder:aCoder];
}


@end
