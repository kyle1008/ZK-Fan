//
//  Service+Conversation.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "Service.h"

@interface Service (Conversation)
-(void)conversationListSucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure;

- (void)conversationsWithUserID:(NSString *)userID sucess:(void(^)(NSArray *))sucess failure:(void (^)(NSError *error))failure;

- (void)postConversationWithUserID:(NSString *)userID text:(NSString *)text  sucess:(void(^)(id result))sucess inReplyID:(NSString *)inReplyID failure:(void (^)(NSError *error))failure;

@end
