//
//  Service.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/27.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

- (void)authoriseWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)(NSString *token,NSString *tokenSecret))sucess;

-(void)requestVerifyCredential:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void(^)(NSDictionary *result)) sucess;

+(instancetype)sharedInstance;

-(void)requestStatusWithSucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure;

-(void) postData:(NSString *)text imageData:(NSData *)imageData replayToStatusID:(NSString *)replayToStatusID repostStatusID:(NSString *)repostStatusID sucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure;

- (void)postPhotoWithPath:(NSString *)path parameters:(NSDictionary *)parameters sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure imageData:(NSData *)imageData;
@end
