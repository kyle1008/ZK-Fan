//
//  Photo+CoreDataProperties.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/1.
//  Copyright © 2016年 kyle. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageurl;
@property (nullable, nonatomic, retain) NSString *thumburl;
@property (nullable, nonatomic, retain) NSString *largeurl;
@property (nullable, nonatomic, retain) Status *status;

@end

NS_ASSUME_NONNULL_END
