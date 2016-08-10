//
//  MessageViewController.m
//  ZK-FanFou
//
//  Created by Kyle.Z on 16/8/9.
//  Copyright © 2016年 kyle. All rights reserved.
//

#import "MessageViewController.h"
#import "Service+Conversation.h"
#import "CoreDataStack+Message.h"
#import <JSQMessagesViewController/JSQMessage.h>
#import <JSQMessagesViewController/UIColor+JSQMessages.h>
#import <JSQMessagesViewController/JSQMessagesBubbleImageFactory.h>
#import <JSQMessagesViewController/JSQSystemSoundPlayer+JSQMessages.h>
#import <JSQSystemSoundPlayer/JSQSystemSoundPlayer.h>
#import "CoreDataStack+User.h"
#import "Message.h"
#import "NSDate+Utility.h"
#import "Service+Message.h"
@interface MessageViewController ()
@property (strong, nonatomic) NSArray *messageList;
@property (copy, nonatomic) NSString *maxID;
@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;
@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;
@end

@implementation MessageViewController

- (void)addTimer {
    
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:10
                                        target:self selector:@selector(refreshData) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    //
    [_timer invalidate];
    _timer = nil;
}


//初始化数据，请求所有的messages
- (void)refreshData {
    [[Service sharedInstance] conversationsWithUserID:_userID sucess:^(NSArray *result) {
        [[CoreDataStack sharedCoreDataStack] addMessagesWithArrayProfile:result];
        //messageList
        _messageList = [[CoreDataStack sharedCoreDataStack] fetchMessagesWithUserID:_userID];
          NSLog(@"%@",_messageList);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self scrollToBottomAnimated:YES];
        });

    }failure:^(NSError *error) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTimer];
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    _currentUser = [CoreDataStack sharedCoreDataStack].currentUser;
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_messageList count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    Message *msg = [_messageList objectAtIndex:indexPath.item];
    
    
    if ([msg.sender_id isEqualToString:self.senderId]) {
        cell.textView.textColor = [UIColor blackColor];
    }
    else {
        cell.textView.textColor = [UIColor whiteColor];
    }
    
    cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    
    
    return cell;
}

#pragma mark - JSQMessagesCollectionViewDataSource
- (NSString *)senderDisplayName {
    return _currentUser.name;
}
- (NSString *)senderId {
    return _currentUser.uId;
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    Message *mg = [_messageList objectAtIndex:indexPath.item];
    JSQMessage *jmg = [[JSQMessage alloc] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName date:mg.created_at text:mg.text];
    return jmg;
    
}
- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath {
    return ;
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Message *msg = [_messageList objectAtIndex:indexPath.item];
    if ([msg.sender_id isEqualToString:_currentUser.uId]) {
        return self.outgoingBubbleImageData;
    } else {
        return self.incomingBubbleImageData;
    }
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    Message *msg = [_messageList objectAtIndex:indexPath.item];
    return [[NSAttributedString alloc] initWithString:[msg.created_at defaultDateString]];
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    return  20;
}

//新建私信
- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    Message *msg = [_messageList lastObject];
    [[Service sharedInstance] postMessageWithUserID:_userID text:text sucess:^(id result) {
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateMessageWithProfile:result];
        _messageList = [[CoreDataStack sharedCoreDataStack] fetchMessagesWithUserID:_userID];
        [self.collectionView reloadData];
        [self finishSendingMessageAnimated:YES];
        
    } inReplyID:msg.mid failure:^(NSError *error) {
        
    }];
    
}

@end