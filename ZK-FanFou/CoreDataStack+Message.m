//
//  CoreDataStack+Message.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack+Message.h"
#import "Message.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"
#import "CoreDataStack+User.h"
#import "User.h"
@implementation CoreDataStack (Message)

-(Message *)insertOrUpdateMessageWithProfile:(NSDictionary *)profile {
    NSString *mid = profile[@"id"];
    NSString *text = profile[@"text"];
    NSString *sender_id = profile[@"sender_id"];
    NSString *recipient_id = profile[@"recipient_id"];
    NSString *sender_screen_name = profile[@"sender_screen_name"];
    NSString *recipient_screen_name = profile[@"recipient_screen_name"];
    NSString *created_at = profile[@"created_at"];
    //用户字典
    NSDictionary *senderProfile = profile[@"sender"];
    NSDictionary *recipientProfile = profile[@"recipient"];
    
    //检查数据库有没有
    Message *msg = (Message *)[self findUniqueEntityWithUniqueKey:@"mid" value:mid entityName:MESSAGE_ENTITY];
    
    if (!msg) {
        msg = [NSEntityDescription  insertNewObjectForEntityForName:MESSAGE_ENTITY inManagedObjectContext:self.context];
    }
    msg.mid = mid;
    msg.text = text;
    msg.sender_id = sender_id;
    msg.recipient_id = recipient_id;
    msg.sender_screen_name = sender_screen_name;
    msg.recipient_screen_name = recipient_screen_name;
    msg.created_at = [self dateFromString:created_at];
    //插入用户表
    User *sender = [self insertOrUpdateWithUserProfile:senderProfile token:nil tokenSecret:nil];
    User *recipient = [self insertOrUpdateWithUserProfile:recipientProfile token:nil tokenSecret:nil];
    msg.sender = sender;
    msg.recipient = recipient;
    
    return msg;
}

- (void)addMessagesWithArrayProfile:(NSArray *)profile  {
    [profile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context performBlockAndWait:^{
            [self insertOrUpdateMessageWithProfile:obj];
            
        }];
        
    }];
    
}

//对话的人可以是recipient_id也可以是sender_id
- (NSArray *)fetchMessagesWithUserID:(NSString *)userID {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"recipient_id = %@ OR sender_id = %@",userID,userID];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:YES];
    
    
    return [self fetchObjectsWithPredicate:pre sortDescriptors:@[descriptor] entityName:MESSAGE_ENTITY];
}
@end
