//
//  Person.h
//  02-objects
//
//  Created by Joseph Asante on 8/25/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *nationality;

- (id) initWithFirstName:(NSString*)firstName;
+ (id) personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName;

@end
