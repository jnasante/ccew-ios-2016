//
//  JNAPerson.m
//  CH8_Assignment1
//
//  Created by CCEW on 9/10/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAPerson.h"

@implementation JNAPerson

- (id) initWithName:(NSString *)firstName lastName:(NSString *)lastName
{
    if (self = [super init])
    {
        _firstName = firstName;
        _lastName = lastName;
    }
    
    return self;
}

// This is the base constructor
- (id) initWithAllInfo:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNumber
{
    if (self = [super init])
    {
        _firstName = firstName;
        _lastName = lastName;
        _phoneNumber = phoneNumber;
    }
    
    return self;
}

- (id) initWithDictionary:(NSDictionary *)aDictionary
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:aDictionary];
    }
    
    return self;
}

+ (id) personWithName:(NSString *)firstName lastName:(NSString *)lastName
{
    return [[JNAPerson alloc] initWithName:firstName lastName:lastName];
}

+ (id) personWithAllInfo:(NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *)phoneNumber
{
    return [[JNAPerson alloc] initWithAllInfo:firstName lastName:lastName phoneNumber:phoneNumber];
}

+ (id) personWithDictionary:(NSDictionary*)aDictionary
{
    return [[JNAPerson alloc] initWithDictionary:aDictionary];
}

- (NSString*) combineFirstAndLastNameIntoPresentableString
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}


/*- (NSDictionary*) dictionaryRepresentation
{
    return [NSD]
}*/

@end
