//
//  ViewController.m
//  NSFoundation-Class
//
//  Created by Joseph Asante on 1/26/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *aString = @"fasdfd";
    
    [aString characterAtIndex:2];
    [aString length];
    
    NSString *lowerCaseString = [aString lowercaseString];
    lowerCaseString = [aString uppercaseString];
    
    NSString *A = @"A";
    NSString *B = @"B";
    
    BOOL equal = [A isEqualToString:B];
    
    NSString *C = [A stringByAppendingString:B];
    
    unichar ch = 'd';
    NSLog(@"%C", ch);
    
    NSInteger integer = 42;
    NSString *answer = [NSString stringWithFormat:@"The answer to the universe is %ld %ld", integer, integer];
    
    NSString *path = @"path/to/resource";
    
    NSString *correctPath = [[@"path" stringByAppendingPathComponent:@"to"] stringByAppendingPathComponent:@"resource"];
    
    NSString *someNumber = @"3";
    NSInteger *myInt = [someNumber integerValue];
    
    NSString *fullString = @"ABCD";
    NSRange r1 = [fullString rangeOfString:@"BC"];
    //NSRange r2 = [fullString rangeOfString:@"asdfhsdjgh"];
    
    NSMutableString *mutable = [NSMutableString stringWithString:@"mutable"];
    NSString *string = [mutable copy];
    
    
    self.mString = [NSMutableString stringWithString:@"blah"];
    
    [self.mString appendString:@"blegh"];
    
    NSLog(@"%@", self.mString);
    
    NSMutableString *someNewString = [string mutableCopy];
    
    NSLocalizedString(@"my word", nil);
    
    NSLog(@"%@ this is so easy %@", string, self.mString);
    
    NSNumber *number = @3.14;
    NSNumber *otherNumber = @3;
    
    BOOL isEqual = [number isEqualToNumber:otherNumber];
    
    NSInteger regularInteger = [number integerValue];
    NSLog(@"%ld", (long)regularInteger);
    
    NSString *stringValue = [number stringValue];
    
    NSDate *today = [NSDate date];
    NSTimeInterval timeInterval = .0000000034;
    NSDate *otherForm = [today dateByAddingTimeInterval:timeInterval];
    
    NSLog(@"%@", today);
    
    //NSDateFormatter
    //NSTimeZone
    //NSDateComponents
    
    NSURL *url = [NSURL URLWithString:@"http://jasante.com/"];
    
    BOOL isFile = [url isFileURL];
    NSString *absolute = [url absoluteString];
    NSString *pathThatIsNotTaken = [url path];
    
    //NSURLRequest
    
    /* Collections */
    NSArray *array = [NSArray arrayWithObjects:@"agf", @3, @" ", nil];
    array = @[ [NSDate date], @"sfd", @3];
    
    [array description];
    
    NSLog(@"%@", array[2]);
    NSLog(@"%@", [array objectAtIndex:2]);
    
    BOOL containsObject = [array containsObject:@3];
    NSUInteger indexOfObject = [array indexOfObject:@"sfd"];
    
    for (NSInteger i = 0; i < [array count]; i++) {
        id object = array[i];
    }
    
    for ( id object in array) {
        NSLog(@"%@", object);
    }
    
    NSMutableArray *myMutableArray = [NSMutableArray arrayWithObjects:@3, nil];
    
    [myMutableArray removeObject:@3];
    NSLog(@"%@", myMutableArray);
    
    myMutableArray = [array mutableCopy];
    [myMutableArray removeObject:@3];
    array = [myMutableArray copy];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value", @"key", @"value2", @"key2", nil];
    
    NSString *otherDict = @{
                            @"key1" : @"value1",
                            @"key2" : @"value2",
                            @"key3" : @4,
                            @"key4" : [NSDate date],
                            @"key5" : @{
                                    @"another" : @"some value"
                                    }
                            };
    
    //[otherDict allKeys];
    //[otherDict allValues];
    
    for (id someKey in dict) {
        id aValue = [dict objectForKey:someKey];
    }
    
    for (id aKey in [dict allKeys]) {
        
    }
    
    //NSSet
}

- (NSArray*) removeObject:(id)object from:(NSArray*)myArray {
    NSMutableArray *myMutableArray = [myArray mutableCopy];
    [myMutableArray removeObject:object];
    return [myMutableArray copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
