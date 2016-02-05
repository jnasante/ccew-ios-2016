//
//  Client.m
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/23/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import "Client.h"

@implementation Client

+ (Client*)sharedInstance {
    static dispatch_once_t once;
    static Client *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return sharedInstance;
}

@end
