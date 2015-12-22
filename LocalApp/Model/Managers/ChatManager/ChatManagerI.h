//
//  ChatManagerI.h
//  ChatModule
//
//  Created by Leo Macbook on 09/02/15.
//  Copyright (c) 2015 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDictionary.h"
#import "Message.h"
#import "Conversation.h"

typedef NS_ENUM(int, ConversationScope)
{
    ConversationScopeTOP,  // no conversations
    ConversationScopeNEW,  // new conversations
    ConversationScopeNEXT  // next conversations
};

@interface ChatManagerI : NSObject
{
    
}

@property (assign, nonatomic) int MaxConversationsInCacheCount;
@property (assign, nonatomic) int MaxMessagesInCacheCount;
@property (assign, nonatomic) BOOL haveUnreadConversation;

@property(strong,nonatomic)CustomDictionary *dict_conversations;
@property(strong,nonatomic)NSMutableArray *array_conversations;

@property(assign,nonatomic)int total_unreadMsgCount;

-(void) clearChatMgr;

-(void) getConversations: (ConversationScope) scope;

-(void) createNewConversation: (NSDictionary*)conversationData;

-(void) deleteConversation: (NSString*)conversationID;

-(void) processConversation:(Conversation *)conversation;

-(void) addNewMessage:(Message *)message withConversation:(Conversation *)conversation;

-(void) updateConversation:(Conversation *)conversation;

-(void) deleteAllConversations;

-(BOOL) cacheGetConversations;

-(BOOL) cacheSaveChat;

@end
