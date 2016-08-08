//
//  ConversationListViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/5.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "ConversationListViewController.h"
#import "Service+Conversation.h"
#import "CoreDataStack+Conversation.h"
//#import "Message.h"
//#import "Conversation.h"
#import "UserTableViewCell.h"
#import "EntityNameConstant.h"
@interface ConversationListViewController ()

@end

@implementation ConversationListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //向服务请求用户列表（和你聊过天的用户）
    //conversation list API
    [[Service sharedInstance] conversationListSucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] addConversationsWithArrayProfile:result];
        //当数据请求成功并插入数据了
        [self configureFetch];
        [self performFetch];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

- (void)configureFetch {
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:CONVERSATION_ENTITY];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"message.created_at" ascending:NO];
    NSArray *descriptors = @[descriptor];
    fr.sortDescriptors = descriptors;
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest: fr managedObjectContext:[CoreDataStack sharedCoreDataStack].context sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;
    
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    Conversation *ct =  [self.frc objectAtIndexPath:indexPath];
    [cell configureWithConversation:ct];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
