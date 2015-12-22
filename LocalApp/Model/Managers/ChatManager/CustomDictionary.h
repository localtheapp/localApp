//
//  CustomDictionary.h
//  Voice
//
//  Created by Leo Macbook on 02/03/15.
//  Copyright (c) 2015 Leo Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Notification_DictionaryUpdated @"Notification_DictionaryUpdated"

@interface CustomDictionary : NSMutableDictionary
{
    NSMutableDictionary *dictionary;
}

//- (void)setCustomObject:(id)anObject forKey:(id)aKey;

@end
