//
//  Message+CoreDataProperties.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message+CoreDataProperties.h"

@implementation Message (CoreDataProperties)

@dynamic created_at;
@dynamic recipient_id;
@dynamic mid;
@dynamic sender_id;
@dynamic sender_screen_name;
@dynamic recipient_screen_name;
@dynamic text;
@dynamic recipient;
@dynamic sender;

@end
