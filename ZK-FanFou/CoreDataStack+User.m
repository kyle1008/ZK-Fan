//
//  CoreDataStack+User.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack+User.h"
#import "User.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"

@implementation CoreDataStack (User)
@dynamic currentUser;

-(User *)checkImportedWithUserID:(NSString *)uId {
    

    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:USER_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uId like %@",uId];
    fr.predicate = predicate;
    
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    return nil;
}
//插入用户数据
-(User *)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret {
    
    //检查数据库是否已有该数组
    //没有插入一条数据，有则更新此条数据
    User *user =  (User *)[self findUniqueEntityWithUniqueKey:@"uId" value:userProfile[@"id"] entityName:USER_ENTITY];
    
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY inManagedObjectContext:self.context];
    }
    user.name = userProfile[@"name"];
    user.uId = userProfile[@"id"];
    user.iconURL = userProfile[@"profile_image_url"];
    user.followers_count = userProfile[@"followers_count"];
    user.friends_count = userProfile[@"friends_count"];
    user.statuses_count = userProfile[@"statuses_count"];
    
    //1.status插入
    //2.user插入
    if (token) {
        user.token = token;
    }
    if (tokenSecret) {
        user.tokenSecret = tokenSecret;
    }

    return user;
}
//根据用户ID查找用户数据
-(User *)findUniqueEntityWithUniqueID:(NSString *)key value:(id)value {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:USER_ENTITY];
    //设置isActive = @YES,支持多用户
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",key, value];
    fr.predicate = predicate;
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    return nil;
}
#pragma mark - currentUser
//currentUser取值方法
-(User *)currentUser {
    //NSString *str = [NSString stringWithFormat:@"%@", @YES];
//    User *user = [self findUniqueEntityWithUniqueID:@"isActive" value:@YES];
//    return user;
    User *currentUser = (User *)[self findUniqueEntityWithUniqueKey:@"isActive" value:@YES entityName:USER_ENTITY];
    return currentUser;
}
#pragma mark - findUserWithId
-(User *)findUserWithId:(NSString *)uId {
    User *user = [self findUniqueEntityWithUniqueID:@"uId" value:uId];
    return user;
}

@end
