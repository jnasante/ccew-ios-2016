//
//  PersonManager.h
//  10-MySQL
//
//  Created by Joseph Asante on 2/10/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface PersonManager : NSObject

@property (strong) FMDatabase *database;
@property (strong, nonatomic) NSArray *people;

+ (instancetype)sharedInstance;

- (NSString*) addressBookPath;
- (void) reloadAddressBook;

@end
