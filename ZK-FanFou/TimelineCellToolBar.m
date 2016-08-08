//
//  TimelineCellToolBar.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/2.
//  Copyright © 2016年 kyle. All rights reserved.

#import "TimelineCellToolBar.h"
@interface TimelineCellToolBar()


@end

@implementation TimelineCellToolBar

- (IBAction)repost:(id)sender forEvent:(UIEvent *)event {
}
- (IBAction)reply:(id)sender forEvent:(UIEvent *)event {
}
- (IBAction)star:(id)sender forEvent:(UIEvent *)event {
    [_delegate starWithTimelineCellToolBar:self sender:sender forEvent:event];
}
-(void)setupStarbtnWithBool:(Boolean)fav {
    //NSString *starbtnTitle;
    if (fav) {
        [_starbtn setTitle:@"已收藏" forState:UIControlStateNormal];
    }else{
        [_starbtn setTitle:@"收藏" forState:UIControlStateNormal];
    }
}
@end
