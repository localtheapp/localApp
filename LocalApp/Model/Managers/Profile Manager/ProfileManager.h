//
//  ProfileManager.h
//  Voice
//
//  Created by Leo Macbook on 23/06/14.
//  Copyright (c) 2014 Leo Macbook. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "JSQMessages.h"

@class User;

@interface ProfileManager : NSObject<CLLocationManagerDelegate, UIAlertViewDelegate> {
  
}

@property (strong, nonatomic) User *owner;

@property (strong, nonatomic) NSMutableArray *helpDeskMessagesArray;

- (void)getProfileInfo;
- (void)updateProfileInfo:(NSDictionary *)profileData;
- (void)updateHomeLocationInfo:(NSDictionary *)locationData;
- (void)turnOnLocationServices;
- (void)turnOffLocationServices;

@end
