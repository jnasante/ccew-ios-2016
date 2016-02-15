//
//  JNAAppDelegate.m
//  CH8_Assignment1
//
//  Created by CCEW on 9/10/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAAppDelegate.h"

@implementation JNAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self copyDefaultAddressBookToDocumentsDirectory];
    
    // Override point for customization after application launch.
    return YES;
}

- (void) copyDefaultAddressBookToDocumentsDirectory
{
    NSString* sourcePath = [[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"plist"];
    
    NSString* destinationPath = [self addressBookPath];
    
    //Creates file for us
    NSFileManager* fm = [[NSFileManager alloc] init];
    NSError* error;
    BOOL success;
    
    // Check if file already exists at the location
    if ( ![fm fileExistsAtPath:destinationPath] )
    {
        success = [fm copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        if (!success) {
            NSLog(@"Problem copying file from %@ to %@, error %@", sourcePath, destinationPath, error);
        }
        else
        {
            NSLog(@"Copied AddressBook.plist");
        }
    }
}

- (NSString*) addressBookPath
{
    NSString* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString* addressBookPath = [documentsPath stringByAppendingPathComponent:@"AddressBook.plist"];

    return addressBookPath;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
