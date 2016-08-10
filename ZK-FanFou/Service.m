//授权访问和接收网络数据
//  Service.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/27.
//  Copyright © 2016年 kyle. All rights reserved.
//
//#ifdef DEBUG
//#define NSLog(FORMAT,...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
//#else
//#define NSLog(...)
//#endif


#import "Service.h"
#import <TDOAuth/TDOAuth.h>
#import "APIContant.h"
#import "CoreDataStack+User.h"
#import "Service+Photo.h"
@interface Service ()
@property(nonatomic, strong) NSURLSession *session;

@end
@implementation Service
//1.获取Service单例对象
+(instancetype)sharedInstance {
    //NSLog(@"%s",__func__);
    static Service *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[Service alloc] init];
    });
    return service;
}
//初始化
-(instancetype)init {
    //NSLog(@"%s",__func__);
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        //60s没响应断开
        cfg.timeoutIntervalForRequest = 60;
        _session = [NSURLSession sessionWithConfiguration:cfg];
    }
    return self;
}
//3.xAuth授权
//目的：获取到[access_token] and [access_secret]
- (void)authoriseWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)(NSString *token,NSString *tokenSecret))sucess {
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
    NSLog(@"oauth: %@",str);
    NSArray *sp1 = [str componentsSeparatedByString:@"="];
    NSString *tokenSecret = sp1[2];
    NSLog(@"tokenSecret: %@",sp1[2]);
    NSString *ele1 = sp1[1];
    //891212-3MdIZyxPeVsFZXFOZj5tAwj6vzJYuLQplzWUmYtWd&oauth_token_secret
    NSArray *sp2 = [ele1 componentsSeparatedByString:@"&"];
    NSString *token = sp2[0];
    NSLog(@"token: %@",sp2[0]);
    sucess(token, tokenSecret);
    }];
    [task resume];
}
//请求用户数据,进入Accounts界面
-(void)requestVerifyCredential:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSDictionary *result)) sucess {
   NSURLRequest *request = [TDOAuth URLRequestForPath:API_VERIFY_CREDENTIALS parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:accessToken tokenSecret:tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateWithUserProfile:result token:accessToken tokenSecret:tokenSecret];
        sucess(result);
    }];
    
    [task resume];
}
//base重构 省略了token和tokenSecret
#pragma mark -BASE REQUEST requestWithPath:parameters:accessToken:tokenSecret:
-(void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure {
    NSURLRequest *request = [TDOAuth URLRequestForPath:path parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:accessToken tokenSecret:tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
            NSLog(@"%@",error);
        } else {
            
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",result);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(result);
            });
            
        }
    }];
    [task resume];
}
//重构base request方法,把access token相关的参数
-(void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod sucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure{
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;  
    NSURLRequest *request = [TDOAuth URLRequestForPath:path parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:user.token tokenSecret:user.tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];

    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
            NSLog(@"%@",error);
        } else {
        
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",result);
            dispatch_async(dispatch_get_main_queue(), ^{
              sucess(result);
            });
        }
    }];
    [task resume];
}
//请求home， time，
-(void)requestStatusWithSucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure {
    [self requestWithPath:API_HOME_TIMELINE parameters:@{@"mode":@"lite",@"count":@60,@"format":@"html"} requestMethod:@"GET" sucess:sucess failure:failure];
}


//收藏
-(void)starWithStatusID:(NSString *)statusID sucess:(void(^)(NSArray *result))sucess failure:(void(^)(NSError *error))failure {
    //NSLog(@"%s",__func__);
    NSString *path = [NSString stringWithFormat:@"%@:%@.json", API_FAVORITES_CREATE, statusID];
    [self requestWithPath:path parameters:nil requestMethod:@"POST" sucess:sucess failure:failure];
}

#pragma mark - POST DATA
//post photo
- (void)postPhotoWithPath:(NSString *)path parameters:(NSDictionary *)parameters sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure imageData:(NSData *)imageData{
    //get current use to aquire token and token secret
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;
    //parameters is nil 是因为后面重新传了这个参数所包含的头
    NSMutableURLRequest *request = [[TDOAuth URLRequestForPath:path parameters:nil host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:user.token tokenSecret:user.tokenSecret scheme:@"http" requestMethod:@"POST" dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1]mutableCopy];
    NSString *boundary = [self generateBoundaryString];
    //-------------------------------------------------------------------------------------------------
    //与发布文本不同的http头和body
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [self createBodyWithBoundary:boundary parameters:parameters data:imageData fileName:@"photo"];
    //-------------------------------------------------------------------------------------------------
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        } else {
            NSArray *result =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",result);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(result);
                
            });
            
        }
    }];
    
    [task resume];
}
@end
