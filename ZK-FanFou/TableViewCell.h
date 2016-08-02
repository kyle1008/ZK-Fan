//
//  TableViewCell.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/28.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableViewCell;
typedef void (^DidSelectPhotoBlock) (TableViewCell *cell);

@class Status;
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;

@property (strong, nonatomic) DidSelectPhotoBlock didSelectPhotoBlock;

-(void)configureWithUser:(Status *)status;
@end
