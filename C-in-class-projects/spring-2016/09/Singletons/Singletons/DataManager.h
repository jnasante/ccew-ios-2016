//
//  DataManager.h
//  Singletons
//
//  Created by Joseph Asante on 2/9/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const DataManagerCreatedObject;

@interface DataManager : NSObject

+ (instancetype)sharedInstance;

@property (strong, nonatomic) NSString *stuff;

@end
