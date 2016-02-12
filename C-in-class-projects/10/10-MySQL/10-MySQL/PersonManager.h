//
//  PersonManager.h
//  10-MySQL
//
//  Created by Joseph Asante on 2/10/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PersonManagerCreatedPerson;

@interface PersonManager : NSObject

+ (instancetype)sharedInstance;

@end