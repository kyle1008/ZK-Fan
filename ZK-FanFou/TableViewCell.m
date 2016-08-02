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
#import <DTCoreText/DTCoreText.h>

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
    //contentsLabel
    NSData *data = [status.text dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *opts = @{DTDefaultFontName:@"HelveticaNeue-Light", DTDefaultFontSize:@16, DTDefaultLinkColor:[UIColor blueColor]};
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithHTMLData:data options:opts documentAttributes:nil];
    self.contentsLabel.attributedString = attributeString;
    self.contentsLabel.numberOfLines = 0;
    
//iconImage
    NSURL *url = [NSURL URLWithString:status.user.iconURL];
    [self.iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"BackgroundAvatar"] options:SDWebImageCacheMemoryOnly];
    
//photoImage
    NSURL *photoURL = [NSURL URLWithString:status.photo.imageurl];
    if (photoURL) {
        //if have photoImage, Height = 200
        _photoImageHeightConstraint.constant = 200;
        
        [self.photoImageView sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"BackgroundImage"] options:SDWebImageProgressiveDownload];
    }else {
        //if no photoImage, Height = 0
        _photoImageHeightConstraint.constant = 0;
        
        [self.photoImageView sd_setImageWithURL:photoURL placeholderImage:nil options:SDWebImageProgressiveDownload];
    }
    
//    [self.photoImage sd_setImageWithURL:photoURL];
    
    //nameLabel
    self.nameLabel.text = status.user.name;
    //publishLabel
    NSDateFormatter *dataFrmatter = [[NSDateFormatter alloc] init];
    dataFrmatter.dateStyle = NSFormattingUnitStyleShort;
    dataFrmatter.timeStyle = NSFormattingUnitStyleShort;
    self.publishLabel.text = [dataFrmatter stringFromDate:status.created_at];
   // self.publishLabel.text = status.sid;
    //发布的内容
    //self.contentsLabel.text = status.text;
    
}


- (IBAction)showLargePhoto:(UIButton *)sender {
    _didSelectPhotoBlock(self);
}

@end
