//
//  JNABookmark.m
//  CH7_Assignment1
//
//  Created by CCEW on 9/8/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNABookmark.h"

@implementation JNABookmark

- (id) initWithInfo:(NSString *)name websiteAddress:(NSString *)websiteAddress
{
    if (self = [super init])
    {
        _name = name;
        _websiteAddress = websiteAddress;
    }
    
    return self;
}

+ (id) bookmarkWithInfo:(NSString*)name websiteAddress:(NSString*)websiteAddress
{
    return [[JNABookmark alloc] initWithInfo:name websiteAddress:websiteAddress];
}

@end
