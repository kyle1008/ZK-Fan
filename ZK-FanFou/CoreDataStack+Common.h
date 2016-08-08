//
//  CoreDataStack+Common.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack (Common)
-(NSManagedObject *)findUniqueEntityWithUniqueKey:(NSString *)key value:(id)value  entityName:(NSString *)entityName;

-(NSDate *)dateFromString:(NSString *)dateStr;
@end
