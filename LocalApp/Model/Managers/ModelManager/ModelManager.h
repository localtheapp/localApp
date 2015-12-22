//
//  ModelManager.h
//  GamePlan
//
//  Created by Kabir Chandoke on 2/23/15.
//  Copyright (c) 2015 Sourcefuse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginManager.h"
#import "ProfileManager.h"
#import "RequestManager.h"
#import "ChatManager.h"
#import "ContactManager.h"
#import "SettingsManager.h"
#import "ChatManager.h"

@interface ModelManager : NSObject

@property (nonatomic,strong) LoginManager   *loginManager;
@property (nonatomic,strong) ProfileManager *profileManager;
@property (nonatomic,strong) RequestManager *requestManager;
@property (strong,nonatomic) ChatManager *chatManager;
@property (strong,nonatomic) ContactManager *contactManager;
@property (strong,nonatomic) SettingsManager *settingManager;

+ (ModelManager *)sharedManager;

//+ (instancetype) new __attribute__((unavailable("new not available")));
//- (instancetype) init __attribute__((unavailable("init not available")));
//- (instancetype) alloc __attribute__((unavailable("alloc not available")));

@end
