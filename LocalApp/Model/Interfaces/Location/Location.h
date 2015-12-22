//
//  Location.h
//  GamePlan
//
//  Created by Kabir Chandoke on 3/19/15.
//  Copyright (c) 2015 Sourcefuse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
{
    
}

@property (strong,nonatomic) NSString *latitude;
@property (strong,nonatomic) NSString *longitude;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *sublocality;
@property (strong,nonatomic) NSString *locality;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *state;
@property (strong,nonatomic) NSString *country;
@property (strong,nonatomic) NSString *pinCode;
@property (strong,nonatomic) NSString *address;

@end
