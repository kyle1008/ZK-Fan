//
//  CoreDataStack+User.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack.h"
#import "User.h"

@interface CoreDataStack (User)

@property (nonatomic, strong) User *currentUser;

-(User *)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret;

//根据用户id查找用户数据
//多用户切换时使用
-(User *)findUserWithId:(NSString *)uId;


@end
