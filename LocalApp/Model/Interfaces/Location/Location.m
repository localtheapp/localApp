//
//  Location.m
//  GamePlan
//
//  Created by Kabir Chandoke on 3/19/15.
//  Copyright (c) 2015 Sourcefuse. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize latitude;
@synthesize longitude;
//@synthesize name;
@synthesize sublocality;
@synthesize locality;
@synthesize city;
@synthesize state;
@synthesize country;
@synthesize pinCode;
@synthesize address;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.latitude=@"";
        self.longitude=@"";
        self.name=@"";
        self.sublocality=@"";
        self.locality=@"";
        self.city=@"";
        self.state=@"";
        self.country=@"";
        self.pinCode=@"";
        self.address=@"";
    }
    return self;
}

@end
