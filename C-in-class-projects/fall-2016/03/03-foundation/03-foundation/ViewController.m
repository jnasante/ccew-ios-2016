//
//  ViewController.m
//  03-foundation
//
//  Created by Joseph Asante on 8/30/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *someString = @"string literal";
    NSString *otherString = @"something else";
    
    [someString isEqualToString:otherString];
    [someString characterAtIndex:2];
    [someString length];
    [someString lowercaseString];
    [someString uppercaseString];
    [someString description];
    
    [someString stringByAppendingString:otherString];
    [someString stringByAppendingFormat:@"%@", otherString];
    
//    System.out.printf("%s blah", otherString);
//    System.out.printf("The answer is: %d %d %d", 5);
    
    NSLog(@"%@ %d %@ ", someString, 5, otherString);
    
    [@"path" stringByAppendingPathComponent:@"resource"];
    [[@"path" stringByAppendingPathComponent:@"to"] stringByAppendingPathComponent:@"resource"];
    
    NSString *someInt = @"5";
    NSInteger integerValue = [someInt integerValue];
    NSLog(@"%ld", (long)integerValue);
    
    NSMutableString *mutable = [someString mutableCopy];
    NSString *immutable = [mutable copy];
    
    self.stringProperty = [NSMutableString stringWithString:@"Cool text"];
    [self.stringProperty appendString:@" with some more cool text"];
    
    NSLog(@"%@", NSLocalizedString(@"Some string", nil));
    
    NSNumber *number = [NSNumber numberWithInteger:42];
    NSNumber *number2 = [NSNumber numberWithInteger:43];
    [number isEqualToNumber:number2];
    
    NSString *numberString = [number stringValue];
    
    NSDate *today = [NSDate date];
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow:3];
    
    NSURL *url = [NSURL URLWithString:@"http:://ccew.ou.edu"];
    NSString *absolute = [url absoluteString];
    
    NSArray *array = [NSArray arrayWithObjects:@"1", @2, @[@3], nil];
    
    NSArray *otherArray = [[NSArray alloc] initWithObjects:@"1", nil];
    NSMutableArray *mutableArray = [array mutableCopy];
    mutableArray[1] = @3;
    array = [mutableArray copy];
    [array objectAtIndex:3];
    
    NSArray *someArray = @[@3, @"2", @[@3]];
    
    [NSString stringWithString:@"string"];
    
    [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSString *testString = [NSString stringWithFormat:@"%@", someString];
    NSDictionary *dictionary = @{
                                 @"key1" : @"value1",
                                 @"key2" : @"value2",
                                 @"key3" : @3,
                                 @"key4" : @{
                                         @"dictionaryceptionkey1" : @"dictionaryceptionvalue1"
                                         }
                                 };
    dictionary.count;
    [dictionary objectForKey:@"key1"];
    NSLog(dictionary[testString]);
    
    for (id key in dictionary) {
        NSLog(@"%@", [dictionary objectForKey:key]);
    }
    
    NSLog(@"%@", someString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
