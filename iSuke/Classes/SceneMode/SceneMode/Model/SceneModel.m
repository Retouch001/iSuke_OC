//
//  SceneModel.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/12.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SceneModel.h"

@implementation Scene

@end

@implementation SceneModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sceneList" : [Scene class]};
}

@end
