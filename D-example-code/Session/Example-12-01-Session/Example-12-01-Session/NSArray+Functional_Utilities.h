//
//  NSArray+Functional_Utilities.h
//  Tailwind
//
//  Created by Philip Dow on 5/29/15.
//  Copyright (c) 2015 Tailwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Functional_Utilities)

- (NSArray*) map:(id(^)(id obj, NSUInteger index))block;
- (NSArray*) flatMap:(id(^)(id obj, NSUInteger index))block;
- (NSArray*) filter:(BOOL(^)(id obj, NSUInteger index))block;

- (NSDictionary*) groupBy:(id<NSCopying>(^)(id obj, NSUInteger index))block;
- (id) select:(BOOL(^)(id obj, NSUInteger index))block;

@end
