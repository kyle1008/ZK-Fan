//
//  TimelineTableViewController.h
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/29.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface TimelineTableViewController : CoreDataTableViewController
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
