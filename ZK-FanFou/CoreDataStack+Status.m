//
//  CoreDataStack+Status.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/29.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack+Status.h"
#import "Status.h"
#import "CoreDataStack+User.h"

static NSString *const STATUS_ENTITY = @"Status";

@implementation CoreDataStack (Status)

-(Status *)checkImportedWithStatusID:(NSString *)sid {
    NSLog(@"%s",__func__);
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:STATUS_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sid like %@",sid];
    fr.predicate = predicate;
    
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    return nil;
}

//插入方法
-(Status *)insertOrUpdateWithStatusProfile:(NSDictionary *)statusProfile {
    NSLog(@"%s",__func__);
    
    Status *status =  [self checkImportedWithStatusID:statusProfile[@"id"]];
    if (!status) {
        status = [NSEntityDescription insertNewObjectForEntityForName:STATUS_ENTITY inManagedObjectContext:self.context];
    }
    
    NSString *dateStr = statusProfile[@"created_at"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MM dd HH:mm:ssZZZZZ yyyy";
    status.created_at = [dateFormatter dateFromString:dateStr];
    
    status.source = statusProfile[@"source"];
    status.text = statusProfile[@"text"];
    status.sid = statusProfile[@"id"];

    
    return status;

}

- (void)insertStatusWithArrayProfile:(NSArray *)arrayProfile
{
    [arrayProfile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context performBlockAndWait:^{
            
            //insert status
          Status *status = [self insertOrUpdateWithStatusProfile:obj];
            
            //insert user
           User *user = [self insertOrUpdateWithUserProfile:obj[@"user"] token:nil tokenSecret:nil];
            
            //set up relationships
            status.user = user;
        }];

        
    }];
}


@end
