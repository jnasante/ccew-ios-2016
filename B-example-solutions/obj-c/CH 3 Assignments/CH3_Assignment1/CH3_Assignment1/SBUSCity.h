//
//  SBUSCity.h
//  CH3_Assignment4
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "SBCity.h"

@interface SBUSCity : SBCity

@property (strong, nonatomic) NSString* state;

@property (strong, nonatomic) NSString* zipCode;

- (id) initWithCity:(NSString*)aCity state:(NSString*)aState;

- (NSString*) description;

@end
