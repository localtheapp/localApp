//
//  ModelManager.m
//  GamePlan
//
//  Created by Kabir Chandoke on 2/23/15.
//  Copyright (c) 2015 Sourcefuse. All rights reserved.
//

#import "ModelManager.h"

@implementation ModelManager

static ModelManager *modelmanager = nil;

#pragma mark - Singleton Model Manager
+ (ModelManager *)sharedManager
{
    if (modelmanager != nil)
    {
        return modelmanager;
    }
    
    static dispatch_once_t pred; // Lock

    dispatch_once(&pred, ^
    { // This code is called at most once per app
        modelmanager = [[ModelManager alloc] init];
    });
    
    return modelmanager;
}
- (id)init
{
    self = [super init];
    
    if (self)
    {
        // Work your initialising magic here as you normally would
        
        //Request Manager
        self.requestManager = [[RequestManager alloc] init];
        
        //Application Managers
        self.loginManager   = [[LoginManager   alloc] init];
        self.profileManager = [[ProfileManager alloc] init];
        self.contactManager = [[ContactManager alloc] init];
        self.settingManager = [[SettingsManager alloc] init];
        self.chatManager = [[ChatManager alloc] init];
      
    }
    return self;
}
@end

