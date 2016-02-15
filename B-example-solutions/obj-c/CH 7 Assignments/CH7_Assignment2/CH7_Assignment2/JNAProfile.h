//
//  JNAProfile.h
//  CH7_Assignment2
//
//  Created by CCEW on 9/9/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNAProfile : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* emailAddress;

- (id) initWithInfo:(NSString*)firstName lastName:(NSString*)lastName emailAddress:(NSString*)emailAddress;

+ (id) profileWithInfo:(NSString*)firstName lastName:(NSString*)lastName emailAddress:(NSString*)emailAddress;

@end
