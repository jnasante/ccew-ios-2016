//
//  SBCity.h
//  CH3_Assignment4
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBCity : NSObject

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* country;

@property (nonatomic) NSInteger* population;

@property (nonatomic) double latitude;

@property (nonatomic) double longitude;

- (id) initWithCity:(NSString*)aCity;

- (NSString*) description;

@end
