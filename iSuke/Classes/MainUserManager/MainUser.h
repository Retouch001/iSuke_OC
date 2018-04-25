//
//  MainUser.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainUser : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger app_user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *pushAlias;

@end
