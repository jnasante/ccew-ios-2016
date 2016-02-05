//
//  Post.h
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/23/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property NSString *ID;
@property NSString *title;
@property NSString *body;
@property NSNumber *author;

- (id) initWithDictionary:(NSDictionary*)aDictionary;
- (NSDictionary*) dictionaryRepresentation;

@end
