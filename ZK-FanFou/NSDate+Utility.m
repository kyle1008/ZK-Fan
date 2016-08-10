//
//  NSDate+Utility.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)

- (NSString *)defaultDateString {
    //formater
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    //日期格式dateFormat
    formater.dateFormat = @"yyyy-MM-dd HH:mm";
    formater.dateStyle = NSDateFormatterShortStyle;
    formater.timeStyle = NSDateFormatterShortStyle;
    //dateFormat->string
    NSString *str = [formater stringFromDate:self];
    return str;
}
@end
