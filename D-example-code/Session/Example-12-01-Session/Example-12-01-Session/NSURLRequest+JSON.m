
//
//  NSURLRequest+JSON.m
//  Tailwind
//
//  Created by Philip Dow on 5/12/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import "NSURLRequest+JSON.h"

@implementation NSURLRequest (JSON)

+ (instancetype) JSONRequestWithURL:(NSURL*)URL method:(NSString*)method body:(NSData*)body
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    request.HTTPMethod = method;
    request.HTTPBody = body;
    
    return request;
}

@end

