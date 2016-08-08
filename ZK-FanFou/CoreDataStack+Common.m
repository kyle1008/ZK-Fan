//
//  CoreDataStack+Common.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack+Common.h"
#import "CoreDataStack+User.h"
@implementation CoreDataStack (Common)
//获取某条数据
-(NSManagedObject *)findUniqueEntityWithUniqueKey:(NSString *)key value:(id)value  entityName:(NSString *)entityName {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",key, value];
    fr.predicate = predicate;
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fr error:&error];
    if (users.count > 0) {
        return users[0];
    }
    return nil;
}
-(NSDate *)dateFromString:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MM dd HH:mm:ssZZZZZ yyyy";
    NSDate *createdDate = [dateFormatter dateFromString:dateStr];
    return createdDate;
}

@end
