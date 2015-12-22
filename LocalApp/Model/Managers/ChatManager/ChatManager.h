//
//  ChatManager.h
//  ChatModule
//
//  Created by Leo Macbook on 09/02/15.
//  Copyright (c) 2015 SF. All rights reserved.
//

#import "ChatManagerI.h"
#import "Conversation.h"
#import "ChatVendorI.h"


#define kNotificationMessageRecieved @"messageRecieved"

@interface ChatManager : ChatManagerI<ChatMessageDelegate>
{
    
}

-(void)didReceivedMessage:(NSDictionary*)messageData;

@end
