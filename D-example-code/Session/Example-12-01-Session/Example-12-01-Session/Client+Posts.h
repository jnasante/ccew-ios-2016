//
//  Client+Posts.h
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/23/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import "Client.h"

@interface Client (Posts)

- (void) GETPosts:(void (^)(id data, NSHTTPURLResponse *response, NSError *error))completionHandler;
- (void) POSTPost:(NSDictionary*)post completionHandler:(void (^)(id data, NSHTTPURLResponse *response, NSError *error))completionHandler;

@end
