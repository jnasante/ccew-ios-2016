//
//  SCViewController.m
//  debug4
//
//  Created by Philip Dow on 1/16/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCViewController.h"

@interface SCViewController ()

@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    NSArray *objects = @[ @"4.56", @"42", @"1001", @3.14, @"99"];
    
    for ( NSString *aString in objects ) {
        NSUInteger length = [aString length];
        NSLog(@"The number is %lu digits long", (unsigned long)length);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
