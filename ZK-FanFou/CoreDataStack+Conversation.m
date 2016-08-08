//
//  CoreDataStack+Conversation.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataStack+Conversation.h"
#import "CoreDataStack+Common.h"
#import "EntityNameConstant.h"
#import "Conversation.h"
#import "Message.h"
#import "CoreDataStack+Message.h"
@implementation CoreDataStack (Conversation)
//单条conversation数据插入
-(Conversation *)insertOrUpdateWithConversationProfile:(NSDictionary *)profile{
    NSString *msg_num = profile[@"msg_num"];
    NSString *otherid = profile[@"otherid"];
    NSString *new_conv = profile[@"new_conv"];
    NSDictionary *msgProfile = profile[@"dm"];
    Conversation *conv =  (Conversation *)[self findUniqueEntityWithUniqueKey:@"otherid" value:otherid entityName: CONVERSATION_ENTITY];
    if (!conv) {
        conv = (Conversation *)[NSEntityDescription insertNewObjectForEntityForName:CONVERSATION_ENTITY inManagedObjectContext:self.context];
    }
    conv.otherid = otherid;
    //NSString 转成 NSNumber(int)
    conv.msg_num = @(msg_num.integerValue);
    conv.new_conv = @(new_conv.boolValue);
    Message *msg = [self insertOrUpdateWithMessageProfile:msgProfile];
    conv.message = msg;
    return conv;
}
-(void)addConversationsWithArrayProfile:(NSArray *)profile {
    //profile-服务器返回的convesation-list的数据（[数组]类型）
    //https://github.com/FanfouAPI/FanFouAPIDoc/wiki/direct-messages.conversation-list
    //数组里面的元素是[字典]类型
    //同步插入
    [self.context performBlockAndWait:^{
        [profile enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            //把数组中每个字典中的元素遍历方法全部插入到数据库
            [self insertOrUpdateWithConversationProfile:dic];
        }];
    }];
}
@end
