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

@implementation UserTableViewCell

-(void)configureWithUser:(User *)user{
    
    self.nameLabel.text = user.name;
    self.idLabel.text = user.uId;
    NSURL *url = [NSURL URLWithString:user.iconURL];
    [self.iconImage sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
    
    
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
