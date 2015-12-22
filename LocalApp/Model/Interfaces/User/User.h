//
//  User.h
//  GamePlan
//
//  Created by Kabir Chandoke on 3/19/15.
//  Copyright (c) 2015 Sourcefuse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface User : NSObject
{
    
}
// User Properties

@property (strong,nonatomic) NSString *userID;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *mobileNumber;
@property (strong,nonatomic) NSString *statusLine;
@property (strong,nonatomic) NSString *profilePicUrl;

@property (strong,nonatomic) Location *currentLocation;

-(void)getUserInfo;

@end
