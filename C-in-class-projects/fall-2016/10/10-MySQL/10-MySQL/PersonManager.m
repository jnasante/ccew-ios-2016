//
//  PersonManager.m
//  10-MySQL
//
//  Created by Joseph Asante on 2/10/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "PersonManager.h"
#import "Person.h"

@implementation PersonManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
