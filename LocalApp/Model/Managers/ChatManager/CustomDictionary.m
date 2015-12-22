//
//  CustomDictionary.m
//  Voice
//
//  Created by Leo Macbook on 02/03/15.
//  Copyright (c) 2015 Leo Macbook. All rights reserved.
//

#import "CustomDictionary.h"


@implementation CustomDictionary

-(instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//- (void)setCustomObject:(id)anObject forKey:(id)aKey
//{
//    //fire notification when adding an object to dictionary
//    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_DictionaryUpdated object:Nil userInfo:nil];
//    
//    [dictionary setObject:anObject forKey:aKey];
//}

- (id)copy
{
    return [self mutableCopy];
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
   if(aKey)
   {
    [dictionary setObject:anObject forKey:aKey];
    
    //fire notification when adding an object to dictionary
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_DictionaryUpdated object:Nil userInfo:nil];
   }
}

- (void)removeObjectForKey:(id)aKey
{
    if(aKey)
    {
        [dictionary removeObjectForKey:aKey];
        
        //fire notification when adding an object to dictionary
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_DictionaryUpdated object:Nil userInfo:nil];
    }
}

- (NSUInteger)count
{
    return [dictionary count];
}

- (id)objectForKey:(id)aKey
{
    return [dictionary objectForKey:aKey];
}

-(NSArray*)allKeys
{
    return dictionary.allKeys;
}

-(NSArray*)allValues
{
   return [dictionary allValues];
}

- (NSEnumerator *)keyEnumerator {
    return [dictionary keyEnumerator];
}

@end
