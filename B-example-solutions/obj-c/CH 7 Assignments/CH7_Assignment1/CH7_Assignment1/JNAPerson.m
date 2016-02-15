//
//  JNAPerson.m
//  CH7_Assignment1
//
//  Created by CCEW on 9/8/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAPerson.h"

@implementation JNAPerson

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

+ (id) personWithInfo:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *)emailAddress
{
    return [[JNAPerson alloc] initWithInfo:firstName lastName:lastName emailAddress:emailAddress];
}

@end
