//
//  CellToolBarView.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/2.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellToolBarView.h"
@class CellToolBarView;

@protocol CellToolBarDelegate
- (void)starWithCellToolBarView:(CellToolBarView *)toolbar sender:(id)sender forEvent:(UIEvent *)event;
//-(void)configure


@end

@interface CellToolBarView : UIView
@property (nonatomic, weak) id <CellToolBarDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *starbtn;
-(void)setupStarbtnWithBool:(Boolean)fav;
@end
