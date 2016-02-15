//
//  SBCity.m
//  CH3_Assignment4
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "SBCity.h"

@implementation SBCity

- (id) initWithCity:(NSString *)aCity
{
    if ( [self init] )
    {
        _name = aCity;
        _country = @"";
        _population = 0;
        _latitude = 0;
        _longitude = 0;
    }
    
    return self;
}

- (NSString*) description
{
    return self.name;
}

@end
