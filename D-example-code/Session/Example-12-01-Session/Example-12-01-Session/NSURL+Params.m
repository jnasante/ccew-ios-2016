//
//  NSURL+Params.m
//  Tailwind
//
//  Created by Philip Dow on 6/9/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import "NSURL+Params.h"

@implementation NSURL (Params)

+ (instancetype) URLWithHost:(NSString*)host path:(NSString*)path params:(NSDictionary*)params
{
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:path relativeToURL:[NSURL URLWithString: host]] resolvingAgainstBaseURL:YES];
    
    if (params && params.count > 0) {
        NSMutableArray *queryItems = [NSMutableArray array];
        
        for ( NSString *key in params ) {
            NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:key value:params[key]];
            [queryItems addObject:item];
        }
        
        components.queryItems = queryItems;
    }
    
    return components.URL;
}

@end
