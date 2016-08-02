//授权访问和接收网络数据
//  Service.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/27.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "Service.h"
#import <TDOAuth/TDOAuth.h>
#import "APIContant.h"
#import "CoreDataStack+User.h"

@interface Service ()
@property(nonatomic, strong) NSURLSession *session;

@end
@implementation Service

+(instancetype)sharedInstance {
    
    
    static Service *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[Service alloc] init];
    });
    
    return service;
}

-(instancetype)init {
    
    
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        //60s没响应断开
        cfg.timeoutIntervalForRequest = 60;
        _session = [NSURLSession sessionWithConfiguration:cfg];
    }
    return self;
}

//xAuth
//获取到(access token) and (access secret)
- (void)authoriseWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)(NSString *token,NSString *tokenSecret))sucess  {
    
    
    NSURLRequest *request = [TDOAuth URLRequestForPath:API_ACCESS_TOKEN
                                         GETParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        userName, @"x_auth_username",
                                                        password, @"x_auth_password",
                                                        @"client_auth", @"x_auth_mode",
                                                        nil]
                                                  host:FANFOU_BASE_HOST
                                           consumerKey:CONSUMER_KEY
                                        consumerSecret:CONSUMER_SECRET
                                           accessToken:nil
                                           tokenSecret:nil];
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"oauth = %@",str);
        //str
        //oauth_token=8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc&oauth_token_secret=x6qpRnlEmW9JbQn4PQVVeVG8ZLPEx6A0TOebgwcuA
       NSArray *sp1 = [str componentsSeparatedByString:@"="];
       NSString *tokenSecret = sp1[2];
        NSLog(@"tokenSecret = %@",sp1[2]);
       NSString *ele1 = sp1[1];
        //891212-3MdIZyxPeVsFZXFOZj5tAwj6vzJYuLQplzWUmYtWd&oauth_token_secret
       NSArray *sp2 = [ele1 componentsSeparatedByString:@"&"];
       NSString *token = sp2[0];
        NSLog(@"token = %@",sp2[0]);
        
        //success:^(NSString *token, NSString *tokenSecret){}
        sucess(token, tokenSecret);
    }];
    
    [task resume];
}


-(void)requestVerifyCredential:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSDictionary *result)) sucess {
    
   NSURLRequest *request = [TDOAuth URLRequestForPath:API_VERIFY_CREDENTIALS parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:accessToken tokenSecret:tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateWithUserProfile:result token:accessToken tokenSecret:tokenSecret];
       
        sucess(result);
        
    }];
    
    [task resume];
}

-(void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure {
    
    NSURLRequest *request = [TDOAuth URLRequestForPath:path parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:accessToken tokenSecret:tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",result);
            sucess(result);
        }
    }];
    [task resume];
}

-(void)requestStatusWithSucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure {
    
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;

    [self requestWithPath:API_HOME_TIMELINE parameters:nil accessToken:user.token tokenSecret:user.tokenSecret requestMethod:@"GET" sucess:sucess failure:failure];
}

@end
