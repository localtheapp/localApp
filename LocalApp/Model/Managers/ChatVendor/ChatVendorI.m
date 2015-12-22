//
//  ChatVendorI.m
//  Voice
//
//  Created by Leo Macbook on 19/02/15.
//  Copyright (c) 2015 Leo Macbook. All rights reserved.
//

#import "ChatVendorI.h"
#import "User.h"
#import "Message.h"

@implementation ChatVendorI
@synthesize messageDelegate;

- (void)initChatClient:(User*)user;
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)destroyChatClient
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)connectWithChatClient
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(void)getHistoryFromPubNub
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
