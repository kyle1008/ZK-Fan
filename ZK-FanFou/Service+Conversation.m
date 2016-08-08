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
@end
