//
//  NSURLSession+JSONTask.h
//  Tailwind
//
//  Created by Philip Dow on 6/20/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSession (JSONTask)

// Simple wrapper for a data task that completes with JSON as an NSArray or NSDictionary

- (NSURLSessionTask *) JSONDataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(id data, NSHTTPURLResponse *response, NSError *error))completionHandler;

@end
