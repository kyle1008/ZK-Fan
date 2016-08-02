//
//  TableViewCell.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/28.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;
@class DTAttributedLabel;
@class TableViewCell;
typedef void (^DidSelectPhotoBlock) (TableViewCell *cell);

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoImageHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *contentsLabel;

@property (strong, nonatomic) DidSelectPhotoBlock didSelectPhotoBlock;

-(void)configureWithUser:(Status *)status;
@end
