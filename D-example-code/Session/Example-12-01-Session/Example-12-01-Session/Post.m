//
//  Post.m
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/23/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import "Post.h"

@implementation Post

- (id) initWithDictionary:(NSDictionary*)aDictionary {
    if ((self=[super init])) {
        
        // Normally you want to access properties with self.prop notation
        // But during method initialization it is better to access the ivars directoy
        
        _ID = aDictionary[@"_id"];
        _title = aDictionary[@"title"];
        _body = aDictionary[@"body"];
        _author = aDictionary[@"author"];
    }
    return self;
}

- (NSDictionary*) dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"_id"] = self.ID ? self.ID : [NSNull null];
    dictionary[@"title"] = self.title ? self.title : [NSNull null];
    dictionary[@"body"] = self.body ? self.body : [NSNull null];
    dictionary[@"author"] = self.author ? self.author : [NSNull null];
    return [dictionary copy];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"{\rID = %@\rtitle = %@\rbody = %@\rauthor=%@\r}",
        self.ID, self.title, self.body, self.author];
}

@end
