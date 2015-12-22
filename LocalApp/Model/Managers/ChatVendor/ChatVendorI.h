//
//  ChatVendorI.h
//  Voice
//
//  Created by Leo Macbook on 19/02/15.
//  Copyright (c) 2015 Leo Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Message;
@class User;

@protocol ChatMessageDelegate <NSObject>

- (void)didReceivedMessage:(NSDictionary *)messageData;

@end

@interface ChatVendorI : NSObject
{
    
}

@property(weak,nonatomic) id<ChatMessageDelegate> messageDelegate;

- (void)initChatClient:(User *)user;
- (void)destroyChatClient;

- (void)connectWithChatClient;

- (void)getHistoryFromPubNub;

@end
