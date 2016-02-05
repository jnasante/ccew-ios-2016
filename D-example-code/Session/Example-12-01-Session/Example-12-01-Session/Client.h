//
//  Client.h
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/23/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject

@property NSURLSession *session;

+ (Client*)sharedInstance;

@end
