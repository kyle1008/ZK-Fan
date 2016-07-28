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

-(User *)checkImportedWithUserID:(NSString *)uid {
    NSLog(@"%s",__func__);

    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:USER_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uId like %@",uid];
    fr.predicate = predicate;
    
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    
    return nil;
}

-(void)insertOrUpdateWithUserProfile:(NSDictionary *)userProfile token:(NSString *)token tokenSecret:(NSString *)tokenSecret {
    NSLog(@"%s",__func__);
    
    User *user =  [self checkImportedWithUserID:userProfile[@"id"]];
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY inManagedObjectContext:self.context];
    }
    user.name = userProfile[@"name"];
    user.uId = userProfile[@"id"];
    user.iconURL = userProfile[@"profile_image_url"];
    user.token = token;
    user.tokenSecret = tokenSecret;
}

//currentUser取值方法
-(User *)currentUser {
    NSLog(@"%s",__func__);
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:USER_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isActive = %@",@YES];
    fr.predicate = predicate;
    
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    
    return nil;
}





@end
