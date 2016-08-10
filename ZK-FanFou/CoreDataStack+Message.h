//
//  CoreDataStack+Message.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack.h"
@class Message;
@interface CoreDataStack (Message)
-(Message *)insertOrUpdateMessageWithProfile:(NSDictionary *)profile;
- (void)addMessagesWithArrayProfile:(NSArray *)profile;
- (NSArray *)fetchMessagesWithUserID:(NSString *)userID;
@end
