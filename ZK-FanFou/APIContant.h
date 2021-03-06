//
//  APIContant.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/27.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>
//饭否API
//https://github.com/FanfouAPI/FanFouAPIDoc/wiki/Apicategory

FOUNDATION_EXPORT NSString *const API_ACCESS_TOKEN;
FOUNDATION_EXPORT NSString *const CONSUMER_KEY;
FOUNDATION_EXPORT NSString *const CONSUMER_SECRET;
FOUNDATION_EXPORT NSString *const FANFOU_API_HOST;
FOUNDATION_EXPORT NSString *const FANFOU_BASE_HOST;
FOUNDATION_EXTERN NSString *const API_VERIFY_CREDENTIALS;
FOUNDATION_EXTERN NSString *const API_HOME_TIMELINE;
FOUNDATION_EXTERN NSString *const API_UPDATE_TEXT;
FOUNDATION_EXTERN NSString *const API_UPLOAD_PHOTO;
//FOUNDATION_EXTERN or extern
//FOUNDATION_EXTERN NSString *const API_FAVORITES_CREATE;
extern NSString *const API_FAVORITES_CREATE;
extern NSString *const API_CONVERSATION_LIST;
extern NSString *const API_CONVERSATION;
//0.https://github.com/FanfouAPI/FanFouAPIDoc/wiki/direct-messages.new
//1.
extern NSString *const API_MESSAGES_NEW;

extern NSString *const API_PHOTOS_TIMELINE;

