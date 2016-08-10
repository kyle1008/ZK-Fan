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
//获取CoreData的某条数据
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

- (NSArray *)fetchObjectsWithUniqueKey:(NSString *)uniqueKey value:(id)value entityName:(NSString *)entityName sortKey:(NSString *)sortKey {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",uniqueKey,value];
    fr.predicate = predicate;
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
    fr.sortDescriptors = @[descriptor];
    
    NSError *error;
    NSArray *arr = [self.context executeFetchRequest:fr error:&error];
    if (error) {
        return @[error.description];
    }
    return arr;
}

- (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)pre sortDescriptors:(NSArray *)sortDescriptors entityName:(NSString *)entityName {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:entityName];
    fr.predicate = pre;
    fr.sortDescriptors = sortDescriptors;
    NSError *error;
    NSArray *arr = [self.context executeFetchRequest:fr error:&error];
    if (error) {
        return @[error.description];
    }
    return arr;
}

@end
