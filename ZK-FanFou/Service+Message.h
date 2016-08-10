//
//  Service+Message.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "Service.h"

@interface Service (Message)
- (void)postMessageWithUserID:(NSString *)userID text:(NSString *)text  sucess:(void(^)(id result))sucess inReplyID:(NSString *)inReplyID failure:(void (^)(NSError *error))failure;
@end
