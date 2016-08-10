//
//  Service+Photo.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "Service+Photo.h"
#import <TDOAuth/TDOAuth.h>
#import "APIContant.h"
#import "CoreDataStack+User.h"
#import "Service.h"

@implementation Service (Photo)

#pragma mark - POST photo
//
- (void)getPhotosUserTimelineWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure; {
    NSDictionary *parameters = @{@"id":userID};
    [self requestWithPath:API_PHOTOS_TIMELINE parameters:parameters requestMethod:@"GET" sucess:sucess failure:failure];
}

-(void) postData:(NSString *)text imageData:(NSData *)imageData replayToStatusID:(NSString *)replayToStatusID repostStatusID:(NSString *)repostStatusID sucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"status"] = text;
    parameters[@"format"] = @"html";
    if (replayToStatusID) {
        parameters[@"in_replay_to_status_id"] = replayToStatusID;
        
    }
    if (repostStatusID) {
        parameters[@"repost_status_id"] = repostStatusID;
    }
    if (imageData) {
        //发布图片的接口
        [self postPhotoWithPath:API_UPLOAD_PHOTO parameters:parameters sucess:sucess failure:failure imageData:imageData];
    }else{
        
        User *user = [CoreDataStack sharedCoreDataStack].currentUser;
        [self requestWithPath:API_UPDATE_TEXT parameters:parameters accessToken:user.token tokenSecret:user.tokenSecret requestMethod:@"POST" sucess:sucess failure:failure];
    }
}

#pragma mark - PhotoUpload
//图片上传的表单格式构造
- (NSData *)createBodyWithBoundary:(NSString *)boundary parameters:(NSDictionary *)parameters data:(NSData *)data fileName:(NSString *)fileName{
    //NSLog(@"%s",__func__);
    NSMutableData *httpBody = [NSMutableData data];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"photo\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:data];
    [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return httpBody;
}

//
- (NSString *)generateBoundaryString{
    //NSLog(@"%s",__func__);
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
}




@end
