//
//  PersonManager.m
//  10-MySQL
//
//  Created by Joseph Asante on 2/10/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "PersonManager.h"

NSString * const PersonManagerCreatedPerson = @"PersonManagerCreatedPerson";

@implementation PersonManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
        // Post notification of person creation
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PersonManagerCreatedPerson
         object:self
         userInfo:nil];
    });
    return sharedInstance;
}

@end
