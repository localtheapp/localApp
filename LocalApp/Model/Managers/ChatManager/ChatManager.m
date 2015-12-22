//
//  ChatManager.m
//  ChatModule
//
//  Created by Leo Macbook on 09/02/15.
//  Copyright (c) 2015 SF. All rights reserved.
//

#import "ChatManager.h"


@interface ChatManager ()
{
    
}

-(void) didReceivedMessage:(NSDictionary *)messageData;

-(BOOL) cacheAddConversation:(Conversation *)conversation;

-(BOOL) cacheDeleteConversation:(NSString *)ConversationID;

-(BOOL) cacheUpdateConversation: (Conversation*)conversation;

-(BOOL) cacheAddNewMessageToConversation:(Conversation*)conversation message:(Message*)message;

-(BOOL) cacheGetConversations;

@end



@implementation ChatManager

#pragma mark Init

- (id)init
{
    self = [super init];
    
    if (self)
    {
      // add notification Observer
      [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_DictionaryUpdated object:Nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:Notification_DictionaryUpdated object:nil];
      
        // Work your initialising magic here as you normally would
        self.dict_conversations = [[CustomDictionary alloc] init];
        self.array_conversations = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

#pragma mark Notification Method

-(void)notificationReceived:(NSNotification *)notification
{
    if([notification.name isEqual:Notification_DictionaryUpdated])
    {
        // prepare the array and sort it from dictionary
        
        NSArray *values = [self.dict_conversations allValues];
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastMessageTime" ascending:NO];

        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        @try {
            self.array_conversations=[[values sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        }
        @catch (NSException *exception) {
            self.array_conversations=[values mutableCopy];
        }
        @finally {
            
        }
        
        //self.array_conversations=[values mutableCopy];
        NSLog(@"Array is : %@",self.array_conversations.description);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationConversationsArrayUpdated object:Nil userInfo:nil];
        
    }
   
}

#pragma mark Convesation Methods

-(void)getConversations: (ConversationScope) scope
{

}

-(void)createNewConversation:(NSDictionary*)conversationData
{
    
}

-(void) deleteConversation:(NSString*)conversationID
{
    [self cacheDeleteConversation:conversationID];
}

-(void) processConversation:(Conversation *)conversation
{
    //we are just placing check for conversation existance
    if([self.dict_conversations objectForKey:conversation.conversationID])
    {
        // already added in dict_conversation
        //[self.dict_conversations setObject:conversation forKey:conversation.conversationID];
        
    }
    else
    {
        //add to the conversation
        [self.dict_conversations setObject:conversation forKey:conversation.conversationID];
        
        //add the conversation to Cache
        [self cacheAddConversation:conversation];
    }
}

-(void) addNewMessage:(Message *)message withConversation:(Conversation *)conversation
{
    //[self cacheAddNewMessageToConversation:conversation message:message];
}

-(void) updateConversation:(Conversation *)conversation
{
    //[self cacheUpdateConversation:conversation];
}

-(void) deleteAllConversations
{
    //[self cacheDeleteAllConversation];
}


#pragma mark Message Recieved Delegate

-(void) didReceivedMessage:(NSDictionary *)messageData;
{
    NSLog(@"message recieved :%@",messageData);
    
    /*
    //add message to conversation
    Message *message=[[Message alloc] init];
    message.text=[messageData objectForKey:@"message"];
    message.type=MessageStatusRECEIVED;
    message.messageID=[messageData objectForKey:@"id"];
    message.userID=[messageData objectForKey:@"sender"];
    message.delayKey=[messageData objectForKey:@"delay_key"];
    message.conversationID=[messageData objectForKey:@"whisper_id"];
    
    
    //message time code
    NSArray *components=[message.messageID componentsSeparatedByString:@"_"];
    //combine sec and usex strings
    NSString *timeStamp=[NSString stringWithFormat:@"%@_%@",[components objectAtIndex:2],[components objectAtIndex:3]];
    message.time=[components objectAtIndex:2];
    
    
    //check if Owner Message
    if ([message.userID isEqualToString:modelmanager.profileManager.owner.userID])
    {
        message.isOwnerMessage=true;
    }
    else
    {
        message.isOwnerMessage=false;
        //set unread variable
        modelmanager.chatManager.haveUnreadConversation=true;
    }
    
    
    //check if conversation is there in model
    if([self.dict_conversations objectForKey:message.conversationID])
    {
        
        //get the conversation from dictionary
        Conversation *conversation=[self.dict_conversations objectForKey:message.conversationID];
        
        //check if msg is already added in converation
        BOOL msgFound=false;
        for (Message *msg in conversation.array_messages)
        {
            if([msg.delayKey isEqualToString:message.delayKey])
            {
                msg.time=message.time;
                
                //update prev_id
                conversation.message_PrevID=[NSString stringWithFormat:@"%@",timeStamp];
                
                //set nextID if conversation contains no msg
                if(conversation.array_messages.count==0)
                    conversation.message_NextID=[NSString stringWithFormat:@"%@",timeStamp];
                
                
                //set last message time in conversation
                conversation.lastMessageTime=message.time;
                
                msgFound=true;
                break;
            }
        }
        
        //if msg not found then add to the conversation
        if(!msgFound)
        {
            //add the message to array of messages in conversation
            [conversation.array_messages addObject:message];
            
            //set last message time in conversation
            conversation.lastMessageTime=message.time;
            
            //increase the unread count
            if(message.isOwnerMessage==false)
                conversation.unreadMessageCount++;
        }
        
    }
    else
    {
        //else add new conversation to list
        Conversation *conversation=[[Conversation alloc] init];
        conversation.conversationID=message.conversationID;
        conversation.creationTime=timeStamp;
        conversation.modificationTime=timeStamp;
        conversation.unreadMessageCount++;
        
        
        //add message to array of messages
        [conversation.array_messages addObject:message];
        
        [self.dict_conversations setObject:conversation forKey:conversation.conversationID];
        
        //fetch the conversation details
        [conversation getConversationDetails];

    }
    
    //post notification for new message
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_DictionaryUpdated object:Nil userInfo:nil];
     */
    
}

#pragma mark Caching methods
/*
-(BOOL) cacheAddConversation:(Conversation *)conversation
{
    //check if Chat object exists in database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Chat"
                                               inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity1];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@", modelmanager.profileManager.owner.userID];
    
    NSError* error1;
    NSArray * fetchedRecords;
    
    fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error1];
    
    // NSLog(@"fetched count :%d",fetchedRecords1.count);
    
    Chat * chat;
    if(fetchedRecords.count>0)
    {
        chat = [fetchedRecords objectAtIndex:0];
    }
    else
    {
        chat = [NSEntityDescription insertNewObjectForEntityForName:@"Chat"
                                                                inManagedObjectContext:self.managedObjectContext];
        chat.userID = modelmanager.profileManager.owner.userID;
        
        NSDate *lastTime = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActiveDate"];
        if(lastTime==nil)
            lastTime = [NSDate date];
        chat.lastMessageTime = lastTime;
    }
    
    ChatConversation * chatConv = [NSEntityDescription insertNewObjectForEntityForName:@"ChatConversation"inManagedObjectContext:self.managedObjectContext];
    chatConv.conversationID=conversation.conversationID;
    chatConv.name = conversation.name;
    chatConv.creationTime=conversation.creationTime;
    chatConv.modificationTime=conversation.modificationTime;
    chatConv.lastMessageTime = [NSString stringWithFormat:@"%@", conversation.lastMessageTime];
    chatConv.unreadMessageCount = [NSNumber numberWithInteger:conversation.unreadMessageCount];
    chatConv.message_PrevID = conversation.message_PrevID;
    chatConv.message_NextID = conversation.message_NextID;
    chatConv.conversationType = [NSNumber numberWithInteger:conversation.conversationType];
    chatConv.conversationImage = conversation.conversationImage;
    chatConv.lastMessage = conversation.lastMessage;
    chatConv.conversationTime = conversation.conversationTime;
    chatConv.matchStatus = conversation.matchStatus;
    chatConv.groupAdminID = conversation.groupAdminID;

    
    for (int i=0; i<conversation.array_messages.count; i++) {
        
        Message *message=[conversation.array_messages objectAtIndex:i];
        
        ChatMessage * chatmessage = [NSEntityDescription insertNewObjectForEntityForName:@"ChatMessage"
                                                                  inManagedObjectContext:self.managedObjectContext];
        
        chatmessage.text=message.text;
        chatmessage.conversationID=message.conversationID;
        chatmessage.messageID=message.messageID;
        chatmessage.contactName=message.contactName;
        chatmessage.contactNumber=message.contactNumber;
        chatmessage.delayKey=message.delayKey;
        chatmessage.isOwnerMessage=[NSNumber numberWithBool:message.isOwnerMessage];
        chatmessage.localMediaUrl=@"";
        chatmessage.matchMessageType=[NSNumber numberWithInt:message.matchMessageType];
        chatmessage.matchPosition=message.matchPosition;
        chatmessage.matchTeam=message.matchTeam;
        chatmessage.messageStatus=[NSNumber numberWithInt:message.messageStatus];
        chatmessage.messageType=[NSNumber numberWithInt:message.messageType];
        chatmessage.time=[NSString stringWithFormat:@"%@",message.time];
        chatmessage.uploadedMediaUrl=message.uploadedMediaUrl;
        chatmessage.latitude=message.locationInfo.latitude;
        chatmessage.longitude=message.locationInfo.longitude;
        
        
        ChatUser * chatUser = [NSEntityDescription insertNewObjectForEntityForName:@"ChatUser"
                                                            inManagedObjectContext:self.managedObjectContext];
        
        chatUser.firstName = message.user.firstName;
        chatUser.lastName = message.user.lastName;
        chatUser.position = message.user.position;
        chatUser.profilePicUrl = message.user.profilePicUrl;
        chatUser.team = message.user.team;
        chatUser.userID = message.user.userID;
        
        chatmessage.user = chatUser;

        //add to the messages array
        [chatConv addArray_messagesObject:chatmessage];
    }
    
    
    //conversation data in ChatConversation
    for (User *user in conversation.array_users)
    {
        ChatUser * chatUser = [NSEntityDescription insertNewObjectForEntityForName:@"ChatUser"
                                                                    inManagedObjectContext:self.managedObjectContext];
        chatUser.userID = user.userID;
        chatUser.profilePicUrl=user.profilePicUrl;
        chatUser.firstName = user.firstName;
        chatUser.lastName  = user.lastName;
        
        //add user to chat Users
        [chatConv addArray_usersObject:chatUser];
    }
    
    //add the conversation to chat

    //[chat insertObject:chatConv inArray_conversationsAtIndex:0];
    [chat addArray_conversationsObject:chatConv];
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"error in saving conversation %@", [error localizedDescription]);
        return NO;
    }
    

    return YES;
}

-(BOOL) cacheDeleteConversation:(NSString *)ConversationID
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Chat"
                                               inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity1];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@", modelmanager.profileManager.owner.userID];
    
    NSError* error;
    NSArray * fetchedRecords;
    
    fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // NSLog(@"fetched count :%d",fetchedRecords1.count);
    
    if(fetchedRecords.count>0)
    {
        Chat *chatObj = [fetchedRecords objectAtIndex:0];
        NSArray *arr_conversations = [chatObj.array_conversations array];
        for(ChatConversation *chatConv in arr_conversations)
        {
            if([[chatConv conversationID] isEqualToString:ConversationID])
            {
                [self.managedObjectContext deleteObject:chatConv];
                break;
            }
        }
    
        NSError *error1;
        if (![self.managedObjectContext save:&error1])
        {
            NSLog(@"error in deleting conversation data %@", [error1 localizedDescription]);
            return NO;
        }
        
    }
    
    return YES;
}

-(BOOL) cacheUpdateConversation: (Conversation*)conversation
{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Chat"
                                               inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity1];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@", modelmanager.profileManager.owner.userID];
    
    NSError* error;
    NSArray * fetchedRecords;
    
    fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // NSLog(@"fetched count :%d",fetchedRecords1.count);
    if(fetchedRecords.count>0)
    {
        Chat *chatObj = [fetchedRecords objectAtIndex:0];
        NSDate *lastTime = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActiveDate"];
        if(lastTime==nil)
            lastTime = [NSDate date];
        chatObj.lastMessageTime = lastTime;
        
        NSArray *arr_conversations = [chatObj.array_conversations array];
        for(ChatConversation *chatConv in arr_conversations)
        {
            if([chatConv.conversationID isEqualToString:conversation.conversationID])
            {
                chatConv.conversationID=conversation.conversationID;
                chatConv.name = conversation.name;
                chatConv.creationTime=conversation.creationTime;
                chatConv.modificationTime=conversation.modificationTime;
                chatConv.lastMessageTime = [NSString stringWithFormat:@"%@", conversation.lastMessageTime];
                chatConv.unreadMessageCount = [NSNumber numberWithInteger:conversation.unreadMessageCount];
                chatConv.message_PrevID = conversation.message_PrevID;
                chatConv.message_NextID = conversation.message_NextID;
                chatConv.conversationType = [NSNumber numberWithInteger:conversation.conversationType];
                chatConv.conversationImage = conversation.conversationImage;
                chatConv.lastMessage = conversation.lastMessage;
                chatConv.conversationTime = conversation.conversationTime;
                chatConv.matchStatus = conversation.matchStatus;
                chatConv.groupAdminID = conversation.groupAdminID;
                
                break;
            }
        }
        NSError *error1;
        if (![self.managedObjectContext save:&error1])
        {
            NSLog(@"error in saving new message %@", [error1 localizedDescription]);
            return NO;
        }
    }
    
    return YES;

}

-(BOOL) cacheAddNewMessageToConversation:(Conversation*)conversation message:(Message*)message
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Chat"
                                               inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity1];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@", modelmanager.profileManager.owner.userID];
    
    NSError* error;
    NSArray * fetchedRecords;
    
    fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // NSLog(@"fetched count :%d",fetchedRecords1.count);
    BOOL isConversationExistsInDB = NO;
    if(fetchedRecords.count>0)
    {
        Chat *chatObj = [fetchedRecords objectAtIndex:0];
        NSDate *lastTime = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActiveDate"];
        if(lastTime==nil)
            lastTime = [NSDate date];
        chatObj.lastMessageTime = lastTime;
        
        NSArray *arr_conversations = [chatObj.array_conversations array];
        
        for(ChatConversation *chatConv in arr_conversations)
        {
            if([chatConv.conversationID isEqualToString:conversation.conversationID])
            {
                isConversationExistsInDB = YES;
                //add the new message to conversation
                ChatMessage * chatmessage = [NSEntityDescription insertNewObjectForEntityForName:@"ChatMessage"
                                                                          inManagedObjectContext:self.managedObjectContext];
                
                chatmessage.text=message.text;
                chatmessage.conversationID=message.conversationID;
                chatmessage.messageID=message.messageID;
                chatmessage.contactName=message.contactName;
                chatmessage.contactNumber=message.contactNumber;
                chatmessage.delayKey=message.delayKey;
                chatmessage.isOwnerMessage=[NSNumber numberWithBool:message.isOwnerMessage];
                chatmessage.localMediaUrl=@"";
                chatmessage.matchMessageType=[NSNumber numberWithInt:message.matchMessageType];
                chatmessage.matchPosition=message.matchPosition;
                chatmessage.matchTeam=message.matchTeam;
                chatmessage.messageStatus=[NSNumber numberWithInt:message.messageStatus];
                chatmessage.messageType=[NSNumber numberWithInt:message.messageType];
                chatmessage.time=[NSString stringWithFormat:@"%@",message.time];
                chatmessage.uploadedMediaUrl=message.uploadedMediaUrl;
                chatmessage.latitude=message.locationInfo.latitude;
                chatmessage.longitude=message.locationInfo.longitude;
                
                
                ChatUser * chatUser = [NSEntityDescription insertNewObjectForEntityForName:@"ChatUser"
                                                                    inManagedObjectContext:self.managedObjectContext];
                
                chatUser.firstName = message.user.firstName;
                chatUser.lastName = message.user.lastName;
                chatUser.position = message.user.position;
                chatUser.profilePicUrl = message.user.profilePicUrl;
                chatUser.team = message.user.team;
                chatUser.userID = message.user.userID;
                
                chatmessage.user = chatUser;
                
                //add to the messages array
                [chatConv addArray_messagesObject:chatmessage];
                
                chatConv.modificationTime = conversation.modificationTime;
                chatConv.lastMessageTime = [NSString stringWithFormat:@"%@", conversation.lastMessageTime];
                chatConv.unreadMessageCount = [NSNumber numberWithInteger:conversation.unreadMessageCount];
                chatConv.name = conversation.name;
                chatConv.conversationImage = conversation.conversationImage;
                
                break;
            }
        }
        if(isConversationExistsInDB == YES)
        {
            NSError *error1;
            if (![self.managedObjectContext save:&error1])
            {
                NSLog(@"error in saving new message %@", [error1 localizedDescription]);
                return NO;
            }
        }
        else
        {
            [self cacheAddConversation:conversation];
        }
    }
    else if(isConversationExistsInDB == NO)
    {
        [self cacheAddConversation:conversation];
    }
    
    return YES;
}

-(BOOL) cacheDeleteAllConversation
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Chat"
                                               inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity1];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@", modelmanager.profileManager.owner.userID];
    
    NSError* error;
    NSArray * fetchedRecords;
    
    fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // NSLog(@"fetched count :%d",fetchedRecords1.count);
    
    if(fetchedRecords.count>0)
    {
        Chat *chatObj = [fetchedRecords objectAtIndex:0];
        
        [self.managedObjectContext deleteObject:chatObj];
        
        
        NSError *error1;
        if (![self.managedObjectContext save:&error1])
        {
            NSLog(@"error in deleting all conversation%@", [error1 localizedDescription]);
            return NO;
        }
        
    }
    
    return YES;
}


-(BOOL) cacheGetConversations
{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Chat"
                                               inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity1];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@", modelmanager.profileManager.owner.userID];
    
    NSError* error1;
    NSArray * fetchedRecords;
    
    fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error1];
    
    // NSLog(@"fetched count :%d",fetchedRecords1.count);
    if(fetchedRecords.count>0)
    {

        Chat *chatObj = [fetchedRecords objectAtIndex:0];
        
        [[NSUserDefaults standardUserDefaults] setObject:chatObj.lastMessageTime forKey:@"lastActiveDate"];
        
        NSDate *lastTime = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActiveDate"];
        if(lastTime==nil)
        {
            lastTime = [NSDate date];
            [[NSUserDefaults standardUserDefaults] setObject:lastTime forKey:@"lastActiveDate"];
        }

        
        NSArray *arr_conversations = [chatObj.array_conversations array];
        for(ChatConversation *chatConv in arr_conversations)
        {
            Conversation *conversation=[[Conversation alloc] init];
            
            conversation.conversationID=chatConv.conversationID;
            conversation.name=chatConv.name;
            conversation.creationTime=chatConv.creationTime;
            conversation.modificationTime=chatConv.modificationTime;
            conversation.lastMessageTime=[NSString stringWithFormat:@"%@", chatConv.lastMessageTime];
            
//            NSTimeInterval timeStamp = (NSTimeInterval)[conversation.lastMessageTime integerValue];
//            
//            NSDate *dateUTC = [NSDate dateWithTimeIntervalSince1970:timeStamp];
//            
//            NSDate *lastTime = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActiveDate"];
//            if(lastTime!=nil)
//            {
//                if ([dateUTC compare:lastTime] == NSOrderedDescending) {
//                    NSLog(@"date1 is later than date2");
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:dateUTC forKey:@"lastActiveDate"];
//                }
//            }
//            else
//                [[NSUserDefaults standardUserDefaults] setObject:dateUTC forKey:@"lastActiveDate"];
            
            conversation.unreadMessageCount=[chatConv.unreadMessageCount integerValue];
            conversation.message_PrevID=chatConv.message_PrevID;
            conversation.message_NextID=chatConv.message_NextID;
            conversation.conversationType=[chatConv.conversationType intValue];
            conversation.conversationImage=chatConv.conversationImage;
            conversation.lastMessage=chatConv.lastMessage;
            conversation.conversationTime=chatConv.conversationTime;
            conversation.matchStatus=chatConv.matchStatus;
            conversation.groupAdminID=chatConv.groupAdminID;

            
            
            //set message data
            NSArray *arr_messages=[chatConv.array_messages array];
            for(ChatMessage *chatmessage in arr_messages)
            {
                Message *message=[[Message alloc] init];
                message.text=chatmessage.text;
                message.time=chatmessage.time;
                message.conversationID=chatmessage.conversationID;
                message.messageID=chatmessage.messageID;
                message.messageType=[chatmessage.messageType intValue];
                message.locationInfo.latitude = chatmessage.latitude;
                message.locationInfo.longitude = chatmessage.longitude;
                message.uploadedMediaUrl=chatmessage.uploadedMediaUrl;
                message.localMediaUrl=chatmessage.localMediaUrl;
                message.isOwnerMessage=[chatmessage.isOwnerMessage boolValue];
                message.messageStatus=[chatmessage.messageStatus intValue];
                message.delayKey=chatmessage.delayKey;
                message.matchTeam=chatmessage.matchTeam;
                message.matchPosition=chatmessage.matchPosition;
                message.matchMessageType=[chatmessage.matchMessageType intValue];
                message.contactName=chatmessage.contactName;
                message.contactNumber=chatmessage.contactNumber;
                
                message.user.userID=chatmessage.user.userID;
                message.user.firstName=chatmessage.user.firstName;
                message.user.lastName=chatmessage.user.lastName;
                message.user.position=chatmessage.user.position;
                message.user.profilePicUrl=chatmessage.user.profilePicUrl;
                message.user.team=chatmessage.user.team;
                
                // add object to message array
                [conversation.array_messages addObject:message];
                
                if(message.matchMessageType==MessageTypeSquad)
                    [conversation.array_messages_squad addObject:message];
                else if(message.matchMessageType==MessageTypeTeam)
                    [conversation.array_messages_team addObject:message];
                
                //NSLog(@"message is %@",message.text);
            }
            
            //sort the messages
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time"
                                                         ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray=[conversation.array_messages sortedArrayUsingDescriptors:sortDescriptors];
            
            [conversation.array_messages removeAllObjects];
            [conversation.array_messages addObjectsFromArray:sortedArray];
            
            
            //add object to the conversation dictionary
            [self.dict_conversations setObject:conversation forKey:conversation.conversationID];
            
            
            
        }
        return YES;
    }
    
    
    return NO;
}

-(BOOL) cacheSaveChat
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Chat"
                                               inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity1];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@", modelmanager.profileManager.owner.userID];
    
    NSError* error;
    NSArray * fetchedRecords;
    
    fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // NSLog(@"fetched count :%d",fetchedRecords1.count);
    if(fetchedRecords.count>0)
    {
        Chat *chatObj = [fetchedRecords objectAtIndex:0];
        NSDate *lastTime = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActiveDate"];
        if(lastTime==nil)
            lastTime = [NSDate date];
        chatObj.lastMessageTime = lastTime;
        NSError *error1;
        if (![self.managedObjectContext save:&error1])
        {
            NSLog(@"error in saving new message %@", [error1 localizedDescription]);
            return NO;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"lastActiveDate"];
    }
    
    return YES;
    

}
*/
#pragma mark Clear Chat Manager

-(void)clearChatMgr
{

}


@end
