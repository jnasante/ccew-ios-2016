//
//  JNAPerson.h
//  CH8_Assignment1
//
//  Created by CCEW on 9/10/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNAPerson : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* phoneNumber;
@property (strong) NSNumber *ID;

@property (strong) NSString *url;

- (NSString*) combineFirstAndLastNameIntoPresentableString;

- (id) initWithName:(NSString*)firstName lastName:(NSString*)lastName;
- (id) initWithAllInfo:(NSString*)firstName lastName:(NSString*)lastName phoneNumber:(NSString*)phoneNumber;
- (id) initWithDictionary:(NSDictionary*)aDictionary;

+ (id) personWithName:(NSString*)firstName lastName:(NSString*)lastName;
+ (id) personWithAllInfo:(NSString*)firstName lastName:(NSString*)lastName phoneNumber:(NSString*)phoneNumber;
+ (id) personWithDictionary:(NSDictionary*)aDictionary;

//- (NSDictionary*) dictionaryRepresentation;

@end
