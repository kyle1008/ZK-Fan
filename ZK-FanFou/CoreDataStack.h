//
//  CoreDataStack.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataStack : NSObject
@property (nonatomic,strong)NSManagedObjectContext *context;


+(instancetype)sharedCoreDataStack;
-(void)saveContext;
@end
