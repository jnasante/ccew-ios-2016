//
//  Person.h
//  Objects-Lesson
//
//  Created by Joseph Asante on 1/21/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *nationality;

- (id) initWithFirstName:(NSString*)inFirstName AndLastName:(NSString*)inLastName;

+ (id) personWithFirstName:(NSString*)inFirstName AndLastName:(NSString*)inLastName;
@end
