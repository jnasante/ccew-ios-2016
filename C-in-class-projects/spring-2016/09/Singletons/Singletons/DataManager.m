//
//  DataManager.m
//  Singletons
//
//  Created by Joseph Asante on 2/9/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "DataManager.h"

NSString * const DataManagerCreatedObject = @"DataManagerCreatedObject";

@implementation DataManager

+ (instancetype) sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DataManagerCreatedObject object:self];
    });
    
    return sharedInstance;
}

@end
