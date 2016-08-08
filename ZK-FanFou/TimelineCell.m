//
//  TimelineCell.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/28.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "TimelineCell.h"
#import "User.h"
#import "Status.h"
#import <UIImageView+WebCache.h>
#import "Photo.h"
#import <DTCoreText/DTCoreText.h>
#import "TimelineCellToolBar.h"
#import "Message.h"
#import "UserTableViewCell.h"
#import "Conversation.h"
@implementation TimelineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//        cell.nameLabel.text = status.user.name;


-(void)configureWithStatus:(Status *)status{
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
    
    _cellToolbar = [self creatCellToolbar];
    //自动布局关闭
    _cellToolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.toolbar addSubview:_cellToolbar];
    //添加约束
    NSLayoutConstraint *top = [_cellToolbar.topAnchor constraintEqualToAnchor:self.toolbar.topAnchor];
    NSLayoutConstraint *bottom = [_cellToolbar.bottomAnchor constraintEqualToAnchor:self.toolbar.bottomAnchor];
    NSLayoutConstraint *left = [_cellToolbar.leftAnchor constraintEqualToAnchor:self.toolbar.leftAnchor];
    NSLayoutConstraint *right = [_cellToolbar.rightAnchor constraintEqualToAnchor:self.toolbar.rightAnchor];
    //激活约束
    top.active = YES;
    bottom.active = YES;
    left.active = YES;
    right.active = YES;
}


- (IBAction)showLargePhoto:(UIButton *)sender {
    _didSelectPhotoBlock(self);
}

-(TimelineCellToolBar *)creatCellToolbar {
    //取到TimelineCellToolBar.xib中所有的view
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TimelineCellToolBar" owner:nil options:nil];
    TimelineCellToolBar *cellToolbar = views[0];
    return cellToolbar;
}

//-(void)setToolbarDelegate:(TimelineCellToolBar *)toolebar{
//    
//}



@end
