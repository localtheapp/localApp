//
//  User.m
//  GamePlan
//
//  Created by Kabir Chandoke on 3/19/15.
//  Copyright (c) 2015 Sourcefuse. All rights reserved.
//

#import "User.h"
#import "Location.h"

@implementation User

- (id)init
{
    self = [super init];
    
    if(self)
    {
        // Work your initialising magic here as you normally would
        self.userID=@"";
        self.email=@"";
        self.name=@"";
        self.mobileNumber=@"";
        self.statusLine=@"";
        self.profilePicUrl=@"";
        self.currentLocation=[[Location alloc] init];
      
    }
    return self;
}

#pragma mark - Get User Info

-(void)getUserInfo
{

}

@end
