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

- (id) initWithDictionary:(NSDictionary*)dictionary {
    self = [self init];
    if(self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }
}

- (id) valueForUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        return [self valueForKey:@"ID"];
    } else {
        return [super valueForUndefinedKey:key];
    }
}

@end
