//
//  ModifyUserIconApi.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/13.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ModifyUserIconApi.h"
#import "AFNetworking.h"


@implementation ModifyUserIconApi{
    NSInteger _app_user_id;
    UIImage *_icon;
}


- (id)initWithApp_user_id:(NSInteger)app_user_id icon:(UIImage *)icon{
    if (self = [super init]) {
        _app_user_id = app_user_id;
        _icon = icon;
    }
    return self;
}


- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self->_icon, 0.9);
        NSString *name = @"image.jpeg";
        NSString *formKey = @"image";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}


- (NSString *)requestUrl{
    return RT_MODIFY_ICON;
}

- (id)requestArgument{
    return @{
             @"app_user_id" : @(_app_user_id)
             };
}

@end
