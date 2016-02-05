//
//  NSURL+Params.h
//  Tailwind
//
//  Created by Philip Dow on 6/9/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Params)

+ (instancetype) URLWithHost:(NSString*)host path:(NSString*)path params:(NSDictionary*)params;

@end
