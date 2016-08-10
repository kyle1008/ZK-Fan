//
//  User+CoreDataProperties.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

@dynamic iconURL;
@dynamic isActive;
@dynamic name;
@dynamic token;
@dynamic tokenSecret;
@dynamic uId;
@dynamic favourites_count;//收藏数
@dynamic friends_count;//关注的人数
@dynamic statuses_count;//自己发的消息数
@dynamic followers_count;//粉丝数
@dynamic statuses;

@end
