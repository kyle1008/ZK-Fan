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
@end
