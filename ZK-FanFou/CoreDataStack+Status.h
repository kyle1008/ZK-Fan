//
//  CoreDataStack+Status.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/29.
//  Copyright © 2016年 kyle. All rights reserved.
//管理model

#import "CoreDataStack.h"
@class Status;
@interface CoreDataStack (Status)
- (void)insertStatusWithArrayProfile:(NSArray *)arrayProfile;

-(Status *)insertOrUpdateWithStatusProfile:(NSDictionary *)statusProfile;
@end
