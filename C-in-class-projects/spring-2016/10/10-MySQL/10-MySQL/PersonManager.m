//
//  PersonManager.m
//  10-MySQL
//
//  Created by Joseph Asante on 2/10/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "PersonManager.h"
#import "FMDatabase.h"
#import "Person.h"

@implementation PersonManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString*) addressBookPath
{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *addressBookPath = [documentsPath stringByAppendingPathComponent:@"AddressBook.sqlite"];
    
    return addressBookPath;
}

- (void) reloadAddressBook
{
    [self openAddressBook];
    
    NSString *query = @"SELECT * FROM PEOPLE";
    FMResultSet *results = [self.database executeQuery:query];
    NSMutableArray *mutablePeople = [NSMutableArray array];
    
    while ([results next]) {
        NSDictionary *aResult = [results resultDictionary];
        Person *person = [[Person alloc] initWithDictionary:aResult];
        [mutablePeople addObject:person];
    }
    
    self.people = mutablePeople;
}

- (void) openAddressBook
{
    if (self.database) {
        return;
    }
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    if (![fm fileExistsAtPath:[self addressBookPath]]) {
        NSLog(@"ERROR. ERROR. Database should exists at this point. Sum'n ain't right.");
    } else {
        self.database = [FMDatabase databaseWithPath:[self addressBookPath]];
        if (![self.database open]) {
            NSLog(@"There was a problem opening the default database");
            self.database = nil;
        }
    }
}

- (void) closeAddressBook
{
    if (!self.database) {
        return;
    }
    
    [self.database close];
    self.database = nil;
}

@end
