//
//  AppDelegate.m
//  10-MySQL
//
//  Created by Joseph Asante on 2/10/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "AppDelegate.h"
#import "PersonManager.h"
#import "fmdb/FMDatabase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self copyDefaultAddressBookToDocumentsDirectory];
    
    return YES;
}

- (void) copyDefaultAddressBookToDocumentsDirectory {
   
    NSString *destinationPath = [[PersonManager sharedInstance] addressBookPath];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"plist"];

    NSFileManager *fm = [[NSFileManager alloc] init];

    // Copy file
    if (![fm fileExistsAtPath:destinationPath]) {
        FMDatabase *database = [FMDatabase databaseWithPath:destinationPath];
        if (![database open]) {
            NSLog(@"You fool! There was a problem creating the default database.");
        } else {
            // ...
            NSString *create = @"CREATE TABLE people( "
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "firstName TEXT, "
            "lastName TEXT, "
            "phoneNumber TEXT)";
            
            BOOL success = [database executeUpdate:create];
            if (!success) {
                NSLog(@"You idiot. Write a better query statement.");
            } else {
                NSArray *people = [NSArray arrayWithContentsOfFile:sourcePath];
                NSString *insert = @"INSERT INTO people (firstName, lastName, phoneNumber) "
                "VALUES (:firstName, :lastName, :phoneNumber)";
                
                for (NSDictionary *person in people) {
                    BOOL success = [database executeUpdate:insert withParameterDictionary:person];
                    if (!success) {
                        NSLog(@"There was a problem adding default data to the destinations table: %@", person);
                    }
                }
            }
            
            [database close];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
