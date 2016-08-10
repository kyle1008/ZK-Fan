//
//  UserTableViewCell.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "UserTableViewCell.h"
#import "User.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Conversation.h"
#import "Message.h"
@implementation UserTableViewCell

-(void)configureWithUser:(User *)user{
    
    self.nameLabel.text = user.name;
    self.idLabel.text = user.uId;
    NSURL *url = [NSURL URLWithString:user.iconURL];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
}

- (void)configureWithConversation:(Conversation *)ct {
    //由于显示不同sender和recipient会彼此转换
    //接受消息时sender是与你对话的人
    /**
     如果otherid等于当前用户，那是不可能的！
     otherid一定是与你对话的人的用户id
     如果otherid等于sender的user id，则是别人在发送消息给你
     反之亦然
     */
    if ([ct.otherid isEqualToString:ct.message.sender.uId]) {
        self.nameLabel.text = ct.message.sender_screen_name;
        
    } else {
        self.nameLabel.text = ct.message.recipient_screen_name;
    }
    
    self.idLabel.text = ct.otherid;
    
    NSURL *url = [NSURL URLWithString:ct.message.recipient.iconURL];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
    
    
    
}

- (void)awakeFromNib {

    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
