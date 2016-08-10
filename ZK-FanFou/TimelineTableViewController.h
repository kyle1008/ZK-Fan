//
//  TimelineTableViewController.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/29.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import <ARSegmentPager/ARSegmentPageController.h>
@interface TimelineTableViewController : CoreDataTableViewController <ARSegmentControllerDelegate>

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
