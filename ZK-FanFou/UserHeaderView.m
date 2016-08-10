//
//  UserHeaderView.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "UserHeaderView.h"
#import "CoreDataStack+User.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "User+CoreDataProperties.h"
@interface UserHeaderView()
//UserHeaderView.xib
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *idLbl;

@property (weak, nonatomic) IBOutlet UIButton *modify;
@property (weak, nonatomic) IBOutlet UIButton *following;
@property (weak, nonatomic) IBOutlet UIButton *followers;
@property (weak, nonatomic) IBOutlet UIButton *messages;

@end
@implementation UserHeaderView
- (void)awakeFromNib {
    [self configureView];
}
//Me->HeaderView
- (void)configureView {
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;
    //iconImage
    NSURL *url = [NSURL URLWithString:user.iconURL];
    [_iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"BackgroundAvatar"] options:SDWebImageProgressiveDownload];
    //name
    _nameLbl.text = user.name;
    //ID
    _idLbl.text = user.uId;
//    NSLog(@"---------------%@---------------%@",user.name, user.uId);
    //friends_count
    NSString *following = [NSString stringWithFormat:@"关注:%@", user.friends_count];
    [_following setTitle:following forState:UIControlStateNormal];
    //followers_count
    NSString *followers = [NSString stringWithFormat:@"粉丝:%@", user.followers_count];
    [_followers setTitle:followers forState:UIControlStateNormal];
    //status_count
    [_following setTitle:following forState:UIControlStateNormal];
    NSString *statuses_count = [NSString stringWithFormat:@"消息:%@",user.statuses_count];
    [_messages setTitle:statuses_count forState:UIControlStateNormal];
    //modify
    [_modify setTitle:@"修改个人信息" forState:UIControlStateNormal];

}

@end
