//
//  AppDelegate.m
//  10-MySQL
//
//  Created by Joseph Asante on 2/10/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "AppDelegate.h"
#import "PersonManager.h"
#import "FMDatabase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self copyDefaultAddressBookToDocumentsDirectory];
    
    return YES;
}

- (void) copyDefaultAddressBookToDocumentsDirectory
{
    NSString *addressBookPath = [[PersonManager sharedInstance] addressBookPath];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"sqlite"];
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    // Copy file
    if (![fm fileExistsAtPath:addressBookPath]) {
        
        FMDatabase *database = [FMDatabase databaseWithPath:addressBookPath];
        
        if (![database open]) {
            NSLog(@"Problem creating database at path %@", addressBookPath);
        } else {
            NSLog(@"Created default database");
            
            // Database stuff
            NSString *create = @"CREATE TABLE people( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "firstName TEXT, "
                "lastName TEXT, "
                "phoneNumber TEXT)";
            
            BOOL success = [database executeUpdate:create];
            if (!success) {
                //error
                NSLog(@"Sorry, I didn't catch that");
            } else {
                NSArray *people = [NSArray arrayWithContentsOfFile:sourcePath];
                NSString *insert = @"INSERT INTO people (firstName, lastName, phoneNumber) "
                    "VALUES (:firstName, :lastName, :phoneNumber)";
                
                for (NSDictionary *person in people) {
                    BOOL success = [database executeUpdate:insert withParameterDictionary:person];
                    if (!success) {
                        NSLog(@"I'm sorry master, I can't do that right now.");
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
