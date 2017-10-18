//
//  ChatViewController.m
//  FireChat
//
//  Created by Michael on 18/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@property NSMutableArray<JSQMessage *> * messages;

@end

@implementation ChatViewController{
    JSQMessagesBubbleImage * outgoingBubbleImageView;
    JSQMessagesBubbleImage * incomingBubbleImageView;
    FIRDatabaseReference * messageRef;
    FIRDatabaseHandle nMessageRefHandle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messages = [@[] mutableCopy];
    self.senderId = [[[FIRAuth auth] currentUser] uid];
    
    outgoingBubbleImageView = [self setupOutgoingBubble];
    incomingBubbleImageView = [self setupIncomingBubble];
    
 self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
 self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    [self observeMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.messages[indexPath.item];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.messages.count;
}

-(JSQMessagesBubbleImage *)setupOutgoingBubble {
    
    JSQMessagesBubbleImageFactory * bubbleImageFactory = [JSQMessagesBubbleImageFactory new];
    return [bubbleImageFactory outgoingMessagesBubbleImageWithColor: [UIColor jsq_messageBubbleBlueColor]];
}

-(JSQMessagesBubbleImage *)setupIncomingBubble {
    
    JSQMessagesBubbleImageFactory * bubbleImageFactory = [JSQMessagesBubbleImageFactory new];
    return [bubbleImageFactory incomingMessagesBubbleImageWithColor: [UIColor jsq_messageBubbleLightGrayColor]];
}

-(id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessage * message = self.messages[indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId])  {
        
        return outgoingBubbleImageView;
    } else {
        
        return incomingBubbleImageView;
    }
}
-(id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

-(void)addMessagewithId:(NSString*)senderId name:(NSString*)name text:(NSString*)text {
    
    JSQMessage * message = [JSQMessage messageWithSenderId:senderId displayName:name text:text];
    
    if (message) {
        
        [self.messages addObject:message];
        NSLog(@"self.messages = %@", self.messages);
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessagesCollectionViewCell * cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    JSQMessage * message = self.messages[indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId])  {
        cell.textView.textColor = [UIColor whiteColor];
    } else {
        cell.textView.textColor = [UIColor blackColor];
    }
    
    return cell;
}

-(void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    FIRDatabaseReference * itemRef = messageRef.childByAutoId;
    NSDictionary * messageItem = [NSDictionary dictionaryWithObjectsAndKeys:senderId, @"senderId", senderDisplayName, @"senderName", text, @"text", nil];
    [itemRef setValue:messageItem];
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    [self finishSendingMessage];
}

-(void)observeMessages {
    messageRef = [self.channelRef child:@"messages"];
    FIRDatabaseQuery * messageQuery = [messageRef queryLimitedToLast:25];
    
    nMessageRefHandle = [messageQuery observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary * messageData = snapshot.value;
        
        NSString * senderId = [messageData objectForKey:@"senderId"];
        NSString * name = [messageData objectForKey:@"senderName"];
        NSString * text = [messageData objectForKey:@"text"];
        
        if (senderId && name && text && ![text isEqualToString:@""]) {
            
            [self addMessagewithId:senderId name:name text:text];
            [self finishReceivingMessage];
            
        } else {
            
            NSLog(@"Error! Could not decode message data");
        }
    }];
    
}

@end
