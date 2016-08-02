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
#import "Photo.h"
static NSString *const STATUS_ENTITY = @"Status";
static NSString *const PHOTO_ENTITY = @"Photo";
@implementation CoreDataStack (Status)

-(Status *)checkImportedWithStatusID:(NSString *)sid {
    
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:STATUS_ENTITY];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sid = %@",sid];
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
    
    
    Status *status =  [self checkImportedWithStatusID:statusProfile[@"sid"]];
    
    Photo *photo = status.photo;
    if (!status) {
        status = [NSEntityDescription insertNewObjectForEntityForName:STATUS_ENTITY inManagedObjectContext:self.context];
        if (!photo) {
            //插入用户发布的图片
            photo = [NSEntityDescription insertNewObjectForEntityForName:PHOTO_ENTITY inManagedObjectContext:self.context];
        }
    }
    //更新用户发布的图片,photo表
    NSDictionary *photoDic = statusProfile[@"photo"];
    photo.imageurl = photoDic[@"imageurl"];
    photo.largeurl = photoDic[@"largeurl"];
    photo.thumburl = photoDic[@"thumburl"];
    //建立status与photo的关系
    status.photo = photo;
    //更新status表
    status.source = statusProfile[@"source"];
    status.text = statusProfile[@"text"];
    status.sid = statusProfile[@"id"];
    
    NSString *dateStr = statusProfile[@"created_at"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MM dd HH:mm:ssZZZZZ yyyy";
    status.created_at = [dateFormatter dateFromString:dateStr];
    
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
