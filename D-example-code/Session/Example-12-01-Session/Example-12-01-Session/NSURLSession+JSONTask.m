//
//  NSURLSession+JSONTask.m
//  Tailwind
//
//  Created by Philip Dow on 6/20/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import "NSURLSession+JSONTask.h"

@implementation NSURLSession (JSONTask)

- (NSURLSessionTask *) JSONDataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(id data, NSHTTPURLResponse *response, NSError *error))completionHandler
{
    NSURLSessionTask *task = [self dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id json = nil;
        if (data && !error) {
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        }
        
        completionHandler(json, (NSHTTPURLResponse*)response, error);
    }];
    
    return task;
}

@end
