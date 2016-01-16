//
//  CCBusiness.h
//  Assignment-02-03
//
//  Created by Philip Dow on 9/1/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCBusiness : NSObject

@property NSString *name;
@property NSString *type;
@property NSString *phone;

@property NSString *street;
@property NSString *city;
@property NSString *zipcode;
@property NSString *state;

// Instead of a method for address, let's make a readonly property so we can
// correctly use dot notation

@property (readonly) NSString *address;

- (void) updateCity:(NSString*)aCity state:(NSString*)aState zipcode:(NSString*)aZipcode;

@end
