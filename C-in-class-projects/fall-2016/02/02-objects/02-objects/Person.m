//
//  Person.m
//  02-objects
//
//  Created by Joseph Asante on 8/25/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id) init
{
    self = [super init];
    if (self != nil) {
        // do stuff here
        _firstName = @"SupaHot";
        _lastName = @"Fire";
        _nationality = @"United States";
    }
    
    return self;
}

- (id) initWithFirstName:(NSString*)firstName
{
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = @"Fire";
        _nationality = @"United States";
    }
    
    return self;
}

+ (id) personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName
{
    Person* person = [[Person alloc] init];
    person.firstName = firstName;
    person.lastName = lastName;
    return person;
}

@end
