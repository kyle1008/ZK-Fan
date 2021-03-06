//
//  CoreDataStack.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()
@property (nonatomic,strong) NSManagedObjectModel *model;
@property (nonatomic,strong) NSPersistentStoreCoordinator *coordinator;

@end

@implementation CoreDataStack

+(instancetype)sharedCoreDataStack{
    
    static CoreDataStack *coreDataStack = nil;//默认值为nil，可不写
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataStack = [[CoreDataStack alloc] init];
    });
    return coreDataStack;
}


//复写取值方法
#pragma mark - model
-(NSManagedObjectModel *)model{

    if (_model) {
        return  _model;
    }
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    //method 1/2
    _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    //_model = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _model;
}

//创建sqlite数据库
//1.
-(NSURL *)documentURL{
    

    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    return urls[0];
}
#pragma mark - coordinator
-(NSPersistentStoreCoordinator *)coordinator{

    if(_coordinator){
        return _coordinator;
    }
    
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    
    NSURL *sqliteURL = [[self documentURL] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error;
    //数据库自动迁移，用MappingModel做数据迁移
    NSDictionary *dic = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@NO};
    
   NSPersistentStore *store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:dic error:&error];
    
    if (!store) {
        NSLog(@"%@",error.description);
    }
    
    return _coordinator;
}

#pragma mark - context
-(NSManagedObjectContext *)context {
    

    if (_context) {
        return _context;
    }
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    _context.persistentStoreCoordinator = self.coordinator;
    return _context;
}

#pragma mark - saveContext
-(void)saveContext{

    NSError *error;
    if(![_context save:&error]){
        NSLog(@"%@",error.description);
    }
    
}

@end
