//
//  UIView+XIB.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/17.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

+ (instancetype)createFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
