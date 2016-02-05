//
//  Client+Posts.m
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/23/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import "Client+Posts.h"

#import "NSURLSession+JSONTask.h"
#import "NSURLRequest+JSON.h"
#import "NSURL+Params.h"

@implementation Client (Posts)

- (void) GETPosts:(void (^)(id data, NSHTTPURLResponse *response, NSError *error))completionHandler {
    
    NSURLSession *session = self.session;

    NSString *host = @"http://localhost:3000";
    NSString *path = @"/api/posts";
    NSDictionary *params = @{};

    NSURL *URL = [NSURL URLWithHost:host path:path params:params];
    NSURLRequest *request = [NSURLRequest JSONRequestWithURL:URL method:@"GET" body:nil];

    NSURLSessionTask *task = [session JSONDataTaskWithRequest:request completionHandler:^(id data, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error GET /api/posts: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(data, response, error);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(data, response, error);
            });
        }
    }];

    [task resume];
}

- (void) POSTPost:(NSDictionary*)post completionHandler:(void (^)(id data, NSHTTPURLResponse *response, NSError *error))completionHandler
{
    NSURLSession *session = self.session;

    NSString *host = @"http://localhost:3000";
    NSString *path = @"/api/posts";
    
    NSDictionary *params = @{};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:post options:0 error:&error];
    
    if ( !data ) {
        NSLog(@"Error converting post to JSON: %@", error);
        NSError *error = [[NSError alloc] initWithDomain:@"NSJSONSerialization" code:0 userInfo:nil];
        completionHandler(nil, nil, error);
        return;
    }
    
    NSURL *URL = [NSURL URLWithHost:host path:path params:params];
    NSURLRequest *request = [NSURLRequest JSONRequestWithURL:URL method:@"POST" body:data];

    NSURLSessionTask *task = [session JSONDataTaskWithRequest:request completionHandler:^(id data, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error POST /api/posts: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(data, response, error);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(data, response, error);
            });
        }
    }];

    [task resume];
}

@end
