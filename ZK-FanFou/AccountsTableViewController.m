//
//  AccountsTableViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/26.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "AccountsTableViewController.h"
#import "CoreDataStack+User.h"
#import "UserTableViewCell.h"
#import "User.h"
@implementation AccountsTableViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureFetch];
    [self performFetch];
    
}

-(void)configureFetch {
    
    
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    
    NSArray *descriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];
    fr.sortDescriptors = descriptors;
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context  sectionNameKeyPath:nil cacheName:nil];

    self.frc.delegate = self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    User *user = [self.frc objectAtIndexPath:indexPath];
//    cell.nameLabel.text = user.name;
//    cell.idLabel.text = user.uId;
    [cell configureWithUser:user];
    
    return cell;
}
@end
