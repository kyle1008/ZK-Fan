//
//  TimelineTableViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/29.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "CoreDataStack+Status.h"
#import "TableViewCell.h"

#import "Status.h"
#import "Service.h"
@interface TimelineTableViewController ()

@end

@implementation TimelineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载xib
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TVcell"];
    self.tableView.estimatedRowHeight = 100;
    
    [[Service sharedInstance] requestStatusWithSucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] insertStatusWithArrayProfile:result];
        
        [self configureFetch];
        [self performFetch];
    } failure:^(NSError *error) {
        
    }];
    

    // Do any additional setup after loading the view.
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureFetch {
    NSLog(@"%s",__func__);
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Status"];
    
    NSArray *descriptors = @[[[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:YES]];
    fr.sortDescriptors = descriptors;
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context  sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVcell"];
    Status *status = [self.frc objectAtIndexPath:indexPath];
    
    [cell configureWithUser:status];
    return cell;
}


@end
