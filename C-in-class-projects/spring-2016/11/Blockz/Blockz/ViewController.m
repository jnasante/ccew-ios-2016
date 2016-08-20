//
//  ViewController.m
//  Blockz
//
//  Created by Joseph Asante on 2/18/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef void(^MyBlock)(NSString *str);

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *localString = @"local string";
    
    MyBlock block = ^void(NSString *str) {
        NSLog(@"%@", localString);
        NSLog(@"My block with str: %@", str);
    };
    
    [self functionWithBlock:block];
    
    NSArray *array = @[@0, @1, @2];
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSNumber *number = array[i];
        [self doStuff:number];
    }
    
    for (NSNumber *number in array) {
        [self doStuff:number];
    }
    
    __weak id weakself = self;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakself doStuff:(NSNumber*)obj];
    }];
    
    NSDictionary *dict = @{
                           @"blah": @"1",
                           @"blegh": @"2",
                           @"blub": @"3"
                           };
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // do stuff
    }];
    
    
}

/*
- (void) myEnumeratedObjectsUsingBLock:( void (^)(id obj, NSInteger idx, BOOL *stop) )block
{
    for (NSInteger i; i < [self count]; i++) {
        id obj = self[i];
        BOOL stop = NO;
        
        block(obj, i, &stop);
        
        if (stop) {
            break;
        }
    }
}*/

- (void)functionWithBlock:(MyBlock)myBlock {
    myBlock(@"blah");
}

- (void) doStuff:(NSNumber*)aNum {
    NSLog(@"%@", aNum);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
