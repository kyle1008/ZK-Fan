//
//  TableViewCell.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/28.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellToolBarView;
@class Status;
@class DTAttributedLabel;
@class TableViewCell;
typedef void (^DidSelectPhotoBlock) (TableViewCell *cell);

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CellToolBarView *toolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoImageHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *contentsLabel;

@property (nonatomic, weak) CellToolBarView *cellToolbar;
@property (strong, nonatomic) DidSelectPhotoBlock didSelectPhotoBlock;
//-(void)configureWithUser:(Status *)status;
-(void)configureWithStatus:(Status *)status;
//-(void)setToolbarDelegate:(CellToolBarView *)toolbar;
@end
