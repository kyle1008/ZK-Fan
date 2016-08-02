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
//-(void)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret;

-(User *)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret;

-(User *)findUserWithId:(NSString *)uId;
//多用户切换时使用
@property (nonatomic, strong) User *currentUser;

@end
