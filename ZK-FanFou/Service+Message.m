
//
//  Service+Message.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "Service+Message.h"
#import "APIContant.h"
#import "Message.h"
@implementation Service (Message)

//3.向服务器请求数据（发私信）
- (void)postMessageWithUserID:(NSString *)userID text:(NSString *)text  sucess:(void(^)(id result))sucess inReplyID:(NSString *)inReplyID failure:(void (^)(NSError *error))failure {
    //创建参数字典
    NSDictionary *pf = @{@"user":userID,@"text":text,@"in_reply_to_id":inReplyID};
    NSLog(@"%@",pf);
    //调用base2方法
    [self requestWithPath:API_MESSAGES_NEW parameters:pf requestMethod:@"POST" sucess:sucess failure:failure];
}

@end
