//
//  MessageI.h
//  ChatModule
//
//  Created by Leo Macbook on 09/02/15.
//  Copyright (c) 2015 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;
@class Conversation;

typedef NS_ENUM(int, MessageType)
{
    MessageTypeTEXT,
    MessageTypeIMAGE,
    MessageTypeVIDEO
};

typedef NS_ENUM(int, MessageStatus)
{
    MessageStatusSENT,
    MessageStatusRECEIVED,
    MessageStatusNOTSENT,
    MessageStatusUPLOADING,
    MessageStatusUPLOADED,
    MessageStatusUPLOADINGFAILED,
    MessageStatusSENDING
};

@interface Message : NSObject
{
    
}

@property(strong,nonatomic) NSString * text;
@property(strong,nonatomic) NSString * time;
@property(strong,nonatomic) NSString *conversationID;
@property(assign,nonatomic) MessageType messageType;
@property(assign,nonatomic) NSString *messageID;

@property(strong,nonatomic) NSString* serverMediaURL;
@property(strong,nonatomic) NSString* localMediaURL;
@property(assign,nonatomic) BOOL isOwnerMessage;
@property(assign,nonatomic) MessageStatus messageStatus;

-(void) uploadMediaContent: (NSString*)mediaURL;
-(void) sendMessage;

@end
