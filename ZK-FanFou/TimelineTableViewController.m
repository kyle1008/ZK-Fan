//
//  TimelineTableViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/29.
//  Copyright © 2016年 kyle. All rights reserved.
//

#ifdef DEBUG
#define NSLog(FORMAT,...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
#else
#define 
#endif

#import "TimelineTableViewController.h"
#import "CoreDataStack+Status.h"
#import "TimelineCell.h"
#import "Status.h"
#import "Photo.h"
#import "Service.h"
#import <JTSImageViewController/JTSImageViewController.h>
#import <SDImageCache.h>
#import "TimelineCellToolBar.h"

@interface TimelineTableViewController () <JTSImageViewControllerInteractionsDelegate,TimelineCellToolBarDelegate>

@end

@implementation TimelineTableViewController

-(void)creatRefreshController {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshData {
    [self requestData];
    [self.refreshControl endRefreshing];
}

-(void)requestData {
    [[Service sharedInstance] requestStatusWithSucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] insertStatusWithArrayProfile:result];
        //主线程加载
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configureFetch];
            [self performFetch];
        });
    } failure:^(NSError *error) {
    
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //调用下拉刷新功能
    [self creatRefreshController];
    
    //加载xib
    UINib *nib = [UINib nibWithNibName:@"TimelineCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TVcell"];
    self.tableView.estimatedRowHeight = 100;
    //动态改变Cell高度[自适应高度]
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self requestData];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureFetch {
    
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Status"];
    
    NSArray *descriptors = @[[[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:NO]];//ascending:NO 发布时间倒序排列
    fr.sortDescriptors = descriptors;
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context  sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
    
    
}

-(void)showPhotoWithCell:(TimelineCell *)cell photo:(Photo *)photo{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:photo.largeurl];
    if (image) {
        imageInfo.image = image;
    } else{
        imageInfo.imageURL = [NSURL URLWithString:photo.largeurl];
    }

    JTSImageViewController *imageViewController = [[JTSImageViewController alloc]initWithImageInfo:imageInfo mode:JTSImageViewControllerMode_Image backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred];
    [imageViewController showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    //imageViewController的设置代理方法
    imageViewController.interactionsDelegate = self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVcell"];
    Status *status = [self.frc objectAtIndexPath:indexPath];
    [cell configureWithStatus:status];
    
    cell.didSelectPhotoBlock = ^(TimelineCell *cell){
        [self showPhotoWithCell:cell photo:status.photo];
    };
    //toobar收藏按钮

    [cell.cellToolbar setupStarbtnWithBool:status.favorited.boolValue];
    cell.cellToolbar.delegate = self;
    
    return cell;
}
#pragma mark - imageViewerDidLongPress
- (void)imageViewerDidLongPress:(JTSImageViewController *)imageViewer atRect:(CGRect)rect{
    UIAlertController *altController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveImage = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(imageViewer.image, self, nil, nil);
    }];
    
    UIAlertAction *CancelSave = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [altController addAction:saveImage];
    [altController addAction:CancelSave];
    
    [imageViewer presentViewController:altController animated:YES completion:nil];
    
}

- (void)starWithTimelineCellToolBar:(TimelineCellToolBar *)toolbar sender:(id)sender forEvent:(UIEvent *)event{
    //取到收藏所在的indexpath（cell）
    //取到所有touch
    NSSet *touches = [event allTouches];
    //取到其中一个touch
    UITouch *touch = [touches anyObject];
    //取touch的location
    CGPoint point = [touch locationInView:self.tableView];
    //获取点击所在位置的indexpath
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    //用frc取到cell下的status对象
    Status *status = [self.frc objectAtIndexPath:indexPath];
    //请求收藏接口
    [[Service sharedInstance] starWithStatusID:status.sid sucess:^(id result) {
        NSLog(@"%@",result);
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateWithStatusProfile:result];
        [toolbar setupStarbtnWithBool:status.favorited.boolValue];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
