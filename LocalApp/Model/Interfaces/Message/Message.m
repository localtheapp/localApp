//
//  MessageI.m
//  ChatModule
//
//  Created by Leo Macbook on 09/02/15.
//  Copyright (c) 2015 SF. All rights reserved.
//

#import "Message.h"
#import "Location.h"
#import "Conversation.h"

@interface Message ()
{
    
}
-(BOOL) cacheAddMessage;
-(BOOL) cacheUpdateMessage:(NSString*) messageID;
@end

@implementation Message

- (id)init
{
    self = [super init];
    if (self)
    {
        // Work your initialising magic here as you normally would
        self.messageID=@"";
        self.localMediaURL=@"";
        self.messageStatus=MessageStatusNOTSENT;
        self.text=@"";
        self.time=@"";
        self.messageType=MessageTypeTEXT;
        self.serverMediaURL=@"";
        self.isOwnerMessage=FALSE;
    }
    return self;
}

-(void) uploadMediaContent: (NSString*)mediaURL
{
    
}

-(void) sendMessage
{
    NSString *contentType;
    if(self.messageType==MessageTypeTEXT)
        contentType = @"text";
    else if(self.messageType==MessageTypeIMAGE)
        contentType = @"image";
    
    // Trim leading and trailing white spaces for message text
    NSString *trimmedString = [self.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.text = trimmedString;
  
    
    
}

-(BOOL) cacheAddMessage
{
    return NO;
}

-(BOOL) cacheUpdateMessage:(NSString*) messageID
{
    return NO;
}

@end
