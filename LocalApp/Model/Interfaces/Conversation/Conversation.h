//
//  ConversationI.h
//  ChatModule
//
//  Created by Leo Macbook on 09/02/15.
//  Copyright (c) 2015 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Message;

@interface Conversation : NSObject
{
    
}

@property(strong,nonatomic) NSString * conversationID;
@property(strong,nonatomic) NSString * name;
@property(strong,nonatomic) NSString * lastMessageTime;
@property(assign,nonatomic) NSInteger unReadMessageCount;
@property(strong,nonatomic) NSMutableArray *messages;


- (void)addMessage:(Message *)message;

@end
