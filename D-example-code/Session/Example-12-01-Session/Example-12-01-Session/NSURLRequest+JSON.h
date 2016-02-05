//
//  NSURLRequest+JSON.h
//  Tailwind
//
//  Created by Philip Dow on 5/12/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (JSON)

+ (instancetype) JSONRequestWithURL:(NSURL*)URL method:(NSString*)method body:(NSData*)body;

@end
