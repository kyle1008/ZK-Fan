//
//  CoreDataStack+User.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack+User.h"
#import "User.h"

NSString *const USER_ENTITY = @"User";
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

-(User *)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret {
    
    
    User *user =  [self checkImportedWithUserID:userProfile[@"id"]];
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY inManagedObjectContext:self.context];
    }
    user.name = userProfile[@"name"];
    user.uId = userProfile[@"id"];
    user.iconURL = userProfile[@"profile_image_url"];
    user.token = token;
    user.tokenSecret = tokenSecret;

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

//currentUser取值方法
-(User *)currentUser {
    //NSString *str = [NSString stringWithFormat:@"%@", @YES];
    User *user = [self findUniqueEntityWithUniqueID:@"isActive" value:@YES];
    return user;
}
//
-(User *)findUserWithId:(NSString *)uId {
    User *user = [self findUniqueEntityWithUniqueID:@"uId" value:uId];
    return user;
}

@end
