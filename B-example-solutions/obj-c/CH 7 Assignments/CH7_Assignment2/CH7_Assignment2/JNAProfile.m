//
//  JNAProfile.m
//  CH7_Assignment2
//
//  Created by CCEW on 9/9/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAProfile.h"

@implementation JNAProfile

- (id) initWithInfo:(NSString*)firstName lastName:(NSString*)lastName emailAddress:(NSString*)emailAddress
{
    if (self = [super init])
    {
        _firstName = firstName;
        _lastName = lastName;
        _emailAddress = emailAddress;
    }
    
    return self;
}

+ (id) profileWithInfo:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *)emailAddress
{
    return [[JNAProfile alloc] initWithInfo:firstName lastName:lastName emailAddress:emailAddress];
}

@end
