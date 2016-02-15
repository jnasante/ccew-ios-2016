//
//  JNAViewController.m
//  CH3_Assignment2
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAViewController.h"

@interface JNAViewController ()

@end

@implementation JNAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSString* text = @"This is a string literal with some text in it";
    
    for (NSInteger i = 0; i < [text length]; i++)
    {
        unichar aChar = [text characterAtIndex:i];
        NSLog(@"%C", aChar);
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
