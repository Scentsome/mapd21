//
//  ChatViewController.h
//  FireChat
//
//  Created by Michael on 18/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageKit;
@import JSQMessagesViewController;
@import FirebaseAuth;
@import FirebaseDatabase;
@interface ChatViewController : JSQMessagesViewController
@property FIRDatabaseReference * channelRef;
@property NSString * displayName;

@end
