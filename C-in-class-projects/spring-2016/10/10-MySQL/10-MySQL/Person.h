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

- (id) initWithDictionary:(NSDictionary*)dictionary;
- (NSString*) fullName;

@property (strong) NSNumber *ID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phoneNumber;

@end
