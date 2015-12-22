//
//  ConversationI.m
//  ChatModule
//
//  Created by Leo Macbook on 09/02/15.
//  Copyright (c) 2015 SF. All rights reserved.
//

#import "Conversation.h"
#import "User.h"
#import "Message.h"

@implementation Conversation

- (id)init
{
  self = [super init];
  if (self)
  {
    // Work your initialising magic here as you normally would
    self.unReadMessageCount=0;
    self.conversationID=@"";
    self.name=@"";
    self.lastMessageTime=@"";
    
    //allocate messages
    self.messages=[[NSMutableArray alloc] init];
  }
  return self;
}

-(void) addMessage:(Message*)message
{
    //set the conversation ID in message object
    message.conversationID = self.conversationID;
    message.isOwnerMessage = YES;
    
    time_t unixTime = (time_t) ([[NSDate date] timeIntervalSince1970]);
    
    long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    
    NSString *strTimeStamp = [NSString stringWithFormat:@"%lld",milliseconds];
    NSLog(@"The Timestamp is = %@",strTimeStamp);
    
    message.time = [NSString stringWithFormat:@"%ld",unixTime];
    
    self.lastMessageTime = [NSString stringWithFormat:@"%@", message.time];
  
    //add message to messages array
    [self.messages addObject:message];
    
    [message sendMessage];
    
    
}

@end
