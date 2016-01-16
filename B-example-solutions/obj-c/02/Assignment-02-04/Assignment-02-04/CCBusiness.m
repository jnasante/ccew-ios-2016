//
//  CCBusiness.m
//  Assignment-02-03
//
//  Created by Philip Dow on 9/1/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "CCBusiness.h"

@implementation CCBusiness

- (NSString*)address
{
    // street, city, state and zip must be set
    
    return [NSString stringWithFormat:@"%@\n%@, %@ %@", self.street, self.city, self.state, self.zipcode];
}

- (void) updateCity:(NSString*)aCity state:(NSString*)aState zipcode:(NSString*)aZipcode
{
    self.city = aCity;
    self.state = aState;
    self.zipcode = aZipcode;
}

- (NSString*) description
{
    return self.name;
}

@end
