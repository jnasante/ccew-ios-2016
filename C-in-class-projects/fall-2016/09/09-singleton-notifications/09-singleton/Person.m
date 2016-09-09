//
//  Person.m
//  09-singleton
//
//  Created by Joseph Asante on 9/6/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id) init {
    self = [super init];
    if (self) {
        self.fullName = @"Bill Clinton";
    }
    
    return self;
}

@end
