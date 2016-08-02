//
//  TableViewCell.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/28.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "TableViewCell.h"
#import "User.h"
#import "Status.h"
#import <UIImageView+WebCache.h>
#import "Photo.h"

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
    
//图像
    
    NSURL *url = [NSURL URLWithString:status.user.iconURL];
    [self.iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"BackgroundAvatar"] options:SDWebImageCacheMemoryOnly];
    
    //发布的图片
    NSURL *photoURL = [NSURL URLWithString:status.photo.imageurl];
    if (status.photo.imageurl) {
        [self.photoImageView sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"BackgroundImage"] options:SDWebImageProgressiveDownload];
    }else {
        [self.photoImageView sd_setImageWithURL:photoURL placeholderImage:nil options:SDWebImageProgressiveDownload];
    }
    
//    [self.photoImage sd_setImageWithURL:photoURL];
    
    //名字
    self.nameLabel.text = status.user.name;
    
    NSDateFormatter *dataFrmatter = [[NSDateFormatter alloc] init];
    dataFrmatter.dateStyle = NSFormattingUnitStyleShort;
    dataFrmatter.timeStyle = NSFormattingUnitStyleShort;

    self.publishLabel.text = [dataFrmatter stringFromDate:status.created_at];
   // self.publishLabel.text = status.sid;
    //发布的内容
    self.contentsLabel.text = status.text;
    
}


- (IBAction)showLargePhoto:(UIButton *)sender {
    _didSelectPhotoBlock(self);
}

@end
