//
//  CoreDataStack+Conversation.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack.h"
@class Conversation;
@interface CoreDataStack (Conversation)
-(Conversation *)insertOrUpdateWithConversationProfile:(NSDictionary *)profile;
-(void)addConversationsWithArrayProfile:(NSArray *)profile;
@end
