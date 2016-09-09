//
//  PersonManager.m
//  09-singleton
//
//  Created by Joseph Asante on 9/6/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "PersonManager.h"
#import "Person.h"

NSString * const PersonManagerCreatedPerson = @"PersonManagerCreatedPerson";

@implementation PersonManager

+ (instancetype) sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void) addPerson:(Person*)person
{
    if (self.people == nil) {
        self.people = @[];
    }
    
    NSMutableArray *mutableCopy = [self.people mutableCopy];
    [mutableCopy addObject:person];
    self.people = mutableCopy;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PersonManagerCreatedPerson object:self userInfo:nil];
}

@end
