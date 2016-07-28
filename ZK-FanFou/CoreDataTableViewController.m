//
//  CoreDataTableViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/7/27.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "CoreDataTableViewController.h"
@interface CoreDataTableViewController ()

@end

@implementation CoreDataTableViewController
-(void)performFetch {
    NSLog(@"%s", __func__);
    
    if (self.frc) {
        NSError *error;
        if (![self.frc performFetch:&error]) {
            NSLog(@"%@", error.description);
        }
        
        [self.tableView reloadData];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%s", __func__);

    return [[self.frc sections] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%s", __func__);

    return [[[self.frc sections] objectAtIndex:section] numberOfObjects];
}
#pragma mark - NSFetchedResults Controller Delegate
-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller{
    NSLog(@"%s", __func__);

    [self.tableView endUpdates];
}

-(void) controller:(NSFetchedResultsController *)controller didChangeSection:(nonnull id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    NSLog(@"%s", __func__);

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
             break;
        default:
            break;
            
}
}

@end
