//
//  UserTableViewCell.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@class Conversation;

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

-(void)configureWithUser:(User *)user;
- (void)configureWithConversation:(Conversation *)ct;
@end
