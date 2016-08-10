//
//  UserTableViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "UserViewController.h"
#import "TimelineTableViewController.h"
#import "CoreDataStack+User.h"
#import "PhotoBrowseViewController.h"

@interface UserViewController ()
@property (nonatomic,strong) NSString *userID;

@end

@implementation UserViewController
//
//override getter方法
//如果为nil，就是当前用户
- (NSString *)userID {
    if (_userID) {
        return _userID;
    }
    return [CoreDataStack sharedCoreDataStack].currentUser.uId;
}

-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"UserHeaderView" owner:nil options:nil];
    return [views lastObject];
}


- (void)viewDidLoad {
    //用storyboard初始化控制器TimelineTableViewController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Timeline" bundle:nil];
    TimelineTableViewController *timelineTableVC = [storyboard instantiateViewControllerWithIdentifier:@"TimelineTableViewController"];
    
    //用storyboard初始化控制器PhotoBrowseViewController
    UIStoryboard *photoBrowse = [UIStoryboard storyboardWithName:@"PhotoBrowse" bundle:nil];
    PhotoBrowseViewController *photoBrowseVC = [photoBrowse instantiateViewControllerWithIdentifier:@"PhotoBrowseViewController"];
    photoBrowseVC.userID = self.userID;
    //UserTVC包含的控制器
    [self setViewControllers:@[timelineTableVC, photoBrowseVC]];
    self.segmentMiniTopInset = 64;
    self.headerHeight = 200;//HeaderView的高度
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
