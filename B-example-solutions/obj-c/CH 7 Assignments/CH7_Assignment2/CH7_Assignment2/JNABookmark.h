//
//  JNABookmark.h
//  CH7_Assignment2
//
//  Created by CCEW on 9/9/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNABookmark : NSObject

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* websiteAddress;

- (id) initWithInfo:(NSString*)name websiteAddress:(NSString*)websiteAddress;

+ (id) bookmarkWithInfo:(NSString*)name websiteAddress:(NSString*)websiteAddress;

@end
