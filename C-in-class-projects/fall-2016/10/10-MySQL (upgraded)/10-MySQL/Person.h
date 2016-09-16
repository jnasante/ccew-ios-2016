//
//  Person.h
//  10-MySQL
//
//  Created by Joseph Asante on 2/11/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PersonManagerCreatedPerson;

@interface Person : NSObject

- (NSString*) fullName;

@property (strong, nonatomic) NSNumber *ID;

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phoneNumber;

- (void) setValue:(id)value forUndefinedKey:(nonnull NSString *)key;
- (id) valueForUndefinedKey:(NSString *)key;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
