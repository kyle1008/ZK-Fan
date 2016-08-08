//
//  TimelineCell.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/28.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimelineCellToolBar;
@class Status;
@class User;
@class DTAttributedLabel;
@class TimelineCell;
@class Conversation;
typedef void (^DidSelectPhotoBlock) (TimelineCell *cell);

@interface TimelineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TimelineCellToolBar *toolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoImageHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *contentsLabel;

@property (nonatomic, weak) TimelineCellToolBar *cellToolbar;
@property (strong, nonatomic) DidSelectPhotoBlock didSelectPhotoBlock;
-(void)configureWithStatus:(Status *)status;

@end
