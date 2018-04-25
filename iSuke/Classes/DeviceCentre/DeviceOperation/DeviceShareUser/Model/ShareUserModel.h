//
//  ShareUserModel.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareUser : NSObject

@property (nonatomic, assign) NSInteger share_user_id;
@property (nonatomic, copy) NSString *friend_alias;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *avatar;

@end


@interface ShareUserModel : NSObject

@property (nonatomic, strong) NSMutableArray<ShareUser *> *shareUserList;

@end
