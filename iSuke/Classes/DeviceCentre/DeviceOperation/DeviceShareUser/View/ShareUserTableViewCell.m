//
//  ShareUserTableViewCell.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/11.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ShareUserTableViewCell.h"
#import "ShareUserModel.h"

@interface ShareUserTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end


@implementation ShareUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)freshCellWithShareUser:(ShareUser *)shareUser{
    if (kStringIsEmpty(shareUser.friend_alias)) {
        if (kStringIsEmpty(shareUser.nickname)) {
            _name.text = shareUser.phone;
        }else{
            _name.text = shareUser.nickname;
        }
    }else{
        _name.text = shareUser.friend_alias;
    }
    _phone.text = shareUser.phone;
    RTNetworkConfig *config = [RTNetworkConfig sharedConfig];
    [self.icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",config.baseUrl,RT_ICON_BASE,shareUser.avatar]] placeholder:[UIImage imageNamed:RTPORTRAIT]];
}

@end
