//
//  SBUSCity.m
//  CH3_Assignment4
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "SBUSCity.h"

@implementation SBUSCity

- (id) initWithCity:(NSString *)aCity state:(NSString *)aState
{
    if ( self = [self initWithCity:aCity] )
    {
        _state = aState;
    }
    
    return self;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@, %@", self.name, self.state];
}

@end
