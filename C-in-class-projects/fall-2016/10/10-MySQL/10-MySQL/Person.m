//
//  Person.m
//  10-MySQL
//
//  Created by Joseph Asante on 2/11/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "Person.h"

NSString * const PersonManagerCreatedPerson = @"PersonManagerCreatedPerson";

@implementation Person

- (id) init {
    if ([super init]) {
        
        _firstName = @"";
        _lastName = @"";
        _phoneNumber = @"";
        
        // Post notification of person creation
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PersonManagerCreatedPerson
         object:self
         userInfo:nil];
    }
    
    return self;
}

- (NSString*) fullName {
    return [_firstName stringByAppendingFormat:@" %@", _lastName];
}

@end
