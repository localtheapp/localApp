//
//  ProfileManager.m
//  Voice
//
//  Created by Leo Macbook on 23/06/14.
//  Copyright (c) 2014 Leo Macbook. All rights reserved.
//

#import "ProfileManager.h"
#import "User.h"

@interface ProfileManager()

@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation ProfileManager

- (id)init
{
    self = [super init];
    if (self)
    {
        // Init the helpDeskArray
        self.helpDeskMessagesArray = [[NSMutableArray alloc] init];
      
        // initialize the owner object
        self.owner=[[User alloc] init];
        
        // Create a location manager
        self.locationManager = [[CLLocationManager alloc] init];
        // Set a delegate to receive location callbacks
        self.locationManager.delegate = self;
        // Start the location manager
        
        
        // Check authorization status (with class method)
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        // User has never been asked to decide on location authorization
        if (status == kCLAuthorizationStatusNotDetermined) {
           
            // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            
        }
        // User has denied location use (either for this app or for all apps
        else if (status == kCLAuthorizationStatusDenied) {
            NSLog(@"Location services denied");
            // Alert the user and send them to the settings to turn on location
            
            NSString *title;
            title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
            NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Settings", nil];
            [alertView show];
            
        }
        //set the desired accuracy
        self.locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
        
        //set the distance filter
        //self.locationManager.distanceFilter=10;
        
        [self.locationManager startUpdatingLocation];
        
    }
    return self;
}

#pragma mark Alert view Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

#pragma mark Location Services Methods

// Wait for location callbacks

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   // NSLog(@"%@", [locations lastObject]);
    
    // Schedule location manager to run again in 60 seconds
    [self.locationManager stopUpdatingLocation];
    //set the delegate to nil
    self.locationManager.delegate = Nil;
    
    CLLocation *location=newLocation;
    
    // set the owner location lat long
//    modelmanager.profileManager.owner.currentLocation.latitude=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
//    modelmanager.profileManager.owner.currentLocation.longitude=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
//    //
//    
//     NSLog(@"latitude : %@ , longitude : %@",modelmanager.profileManager.owner.currentLocation.latitude,modelmanager.profileManager.owner.currentLocation.longitude);
  
    // if location is 0
    
    if (!location || (int)location.coordinate.latitude==0 || (int)location.coordinate.longitude==0)
    {
        return;
    }
    
    }



-(void)turnOnLocationServices
{
    //set the delegate to self
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

-(void)turnOffLocationServices
{
    //set the delegate to nil
    self.locationManager.delegate = Nil;
    [self.locationManager stopUpdatingLocation];
}

#pragma mark Profile Info

-(void)getProfileInfo
{
    [self.owner getUserInfo];
}

-(void)updateProfileInfo :(NSDictionary*)profileData
{

}

#pragma mark Update location info 

-(void)updateHomeLocationInfo :(NSDictionary*)locationData {
  
}

@end
