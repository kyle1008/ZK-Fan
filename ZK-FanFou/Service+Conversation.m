//
//  Service+Conversation.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "Service+Conversation.h"
#import "Service.h"
#import "APIContant.h"
@implementation Service (Conversation)

-(void)conversationListSucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure{
    [self requestWithPath:API_CONVERSATION_LIST parameters:nil requestMethod:@"GET" sucess:sucess failure:failure];
}

- (void)conversationsWithUserID:(NSString *)userID sucess:(void(^)(NSArray *))sucess failure:(void (^)(NSError *error))failure {
    NSDictionary *profile = @{@"id":userID};
    [self requestWithPath:API_CONVERSATION parameters:profile requestMethod:@"GET" sucess:sucess failure:failure];
    
}

- (void)postConversationWithUserID:(NSString *)userID text:(NSString *)text  sucess:(void(^)(id result))sucess inReplyID:(NSString *)inReplyID failure:(void (^)(NSError *error))failure {
    NSDictionary *pf = @{@"user":userID,@"text":text,@"in_reply_to_id":inReplyID};
    
    NSLog(@"%@",pf);
    [self requestWithPath:API_MESSAGES_NEW parameters:pf requestMethod:@"POST" sucess:sucess failure:failure];
}

@end
