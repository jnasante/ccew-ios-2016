//
//  JNAPerson.h
//  CH7_Assignment1
//
//  Created by CCEW on 9/8/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNAPerson : NSObject

@property (strong, nonatomic) NSString* firstName;

@property (strong, nonatomic) NSString* lastName;

@property (strong, nonatomic) NSString* emailAddress;

- (id) initWithInfo:(NSString*)firstName lastName:(NSString*)lastName emailAddress:(NSString*)emailAddress;

+ (id) personWithInfo:(NSString*)firstName lastName:(NSString*)lastName emailAddress:(NSString*)emailAddress;

@end
