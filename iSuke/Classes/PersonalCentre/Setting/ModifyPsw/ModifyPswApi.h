//
//  ModifyPswApi.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/24.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTBaseRequest.h"

@interface ModifyPswApi : RTBaseRequest
- (id)initWithApp_user_id:(NSInteger)app_user_id oldPsw:(NSString *)oldPsw newPsw:(NSString *)newPsw;
@end
