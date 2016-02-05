//
//  NSArray+Functional_Utilities.m
//  Tailwind
//
//  Created by Philip Dow on 5/29/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import "NSArray+Functional_Utilities.h"

@implementation NSArray (Functional_Utilities)

- (NSArray*) map:(id(^)(id obj, NSUInteger index))block
{
    NSMutableArray *results = [NSMutableArray array];
    NSUInteger i = 0;
    
    for ( id obj in self ) {
        id result = block(obj, i++);
        [results addObject:result ? result : [NSNull null]];
    }
    
    return results;
}

- (NSArray*) flatMap:(id(^)(id obj, NSUInteger index))block
{
    NSMutableArray *results = [NSMutableArray array];
    NSUInteger i = 0;
    
    for ( id obj in self ) {
        id result = block(obj, i++);
        if (result) {
            [results addObjectsFromArray:result];
        }
    }
    
    return results;
}

- (NSArray*) filter:(BOOL(^)(id obj, NSUInteger index))block
{
    NSMutableArray *results = [NSMutableArray array];
    NSUInteger i = 0;
    
    for ( id obj in self ) {
        BOOL result = block(obj, i++);
        if (result) {
            [results addObject:obj];
        };
    }
    
    return results;
}

- (NSDictionary*) groupBy:(id<NSCopying>(^)(id obj, NSUInteger index))block
{
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    NSUInteger i = 0;
    
    for ( id obj in self ) {
        id result = block(obj, i++);
        if ( !result ) {
            result = [NSNull null];
        }
        if ( !results[result] ) {
            results[result] = [NSMutableArray array];
        }
        [results[result] addObject:obj];
    }
    
    return results;
}

- (id) select:(BOOL(^)(id obj, NSUInteger index))block
{
    id selected = nil;
    NSUInteger i = 0;
    
    for ( id obj in self ) {
        if ( block(obj, i++) ) {
            selected = obj;
            break;
        }
    }
    
    return selected;
}

@end
