//
//  TableViewCell.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/28.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "TableViewCell.h"
#import "Status+CoreDataProperties.h"
#import "User.h"
#import <UIImageView+WebCache.h>
#import "Status.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//        cell.nameLabel.text = status.user.name;

-(void)configureWithUser:(Status *)status
{
    NSLog(@"%s", __func__);
    //图像
    NSURL *url = [NSURL URLWithString:status.user.iconURL];
    [self.iconImage sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
    //名字
    self.nameLabel.text = status.user.name;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSFormattingUnitStyleShort;
    df.timeStyle = NSFormattingUnitStyleShort;

    self.publishLabel.text = [df stringFromDate:status.created_at];
   // self.publishLabel.text = status.sid;
    //发布的内容
    self.contentsLabel.text = status.text;
    
}
@end
