//
//  PersonManager.h
//  09-singleton
//
//  Created by Joseph Asante on 9/6/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PersonManagerCreatedPerson;

@class Person;

@interface PersonManager : NSObject

+ (instancetype) sharedInstance;

@property (strong, nonatomic) NSArray *people;

- (void) addPerson:(Person*)person;

@end
