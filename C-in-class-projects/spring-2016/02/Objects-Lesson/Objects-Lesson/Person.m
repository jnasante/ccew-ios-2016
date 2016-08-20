//
//  Person.m
//  Objects-Lesson
//
//  Created by Joseph Asante on 1/21/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id) init {
    self = [super init];
    if ( self ) {
        _firstName = @"John";
        _lastName = @"Smith";
        _nationality = @"United States";
    }
    
    return self;
}

- (id) initWithFirstName:(NSString*)inFirstName andLastName:(NSString*)inLastName {
    if (self = [self init]) {
        _firstName = inFirstName;
        _lastName = inLastName;
    }
    
    return self;
}

+ (id) personWithFirstName:(NSString*)inFirstName lastName:(NSString*)inLastName {
    Person *person = [[Person alloc] initWithFirstName:inFirstName AndLastName:inLastName];
    
    return person;
}

@end
