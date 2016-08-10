//
//  Service+Photo.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "Service.h"

@interface Service (Photo)

-(void) postData:(NSString *)text imageData:(NSData *)imageData replayToStatusID:(NSString *)replayToStatusID repostStatusID:(NSString *)repostStatusID sucess:(void (^)(NSArray *result)) sucess failure:(void (^)(NSError *error)) failure;

- (NSData *)createBodyWithBoundary:(NSString *)boundary parameters:(NSDictionary *)parameters data:(NSData *)data fileName:(NSString *)fileName;

- (NSString *)generateBoundaryString;

- (void)getPhotosUserTimelineWithUserID:(NSString *)userID sucess:(void(^)(id result))sucess failure:(void (^)(NSError *error))failure;
@end
