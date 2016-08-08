//
//  TimelineCellToolBar.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/2.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimelineCellToolBar;
@protocol TimelineCellToolBarDelegate
@required
- (void)starWithTimelineCellToolBar:(TimelineCellToolBar *)toolbar sender:(id)sender forEvent:(UIEvent *)event;

@end

@interface TimelineCellToolBar: UIView
@property (nonatomic, weak) id <TimelineCellToolBarDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *starbtn;
-(void)setupStarbtnWithBool:(Boolean)fav;
@end
