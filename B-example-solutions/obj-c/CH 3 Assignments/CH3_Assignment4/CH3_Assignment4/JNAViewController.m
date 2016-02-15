//
//  JNAViewController.m
//  CH3_Assignment4
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) checkIfStringA:(NSString*)stringA isEqualToStringB:(NSString*)stringB
{
    if ( [stringA isEqualToString:stringB] )
        return YES;
    else
        return NO;
}

- (BOOL) checkIfLowercaseStringA:(NSString*)stringA isEqualToLowercaseStringB:(NSString*)stringB
{
    if ( [[stringA lowercaseString] isEqualToString:[stringB lowercaseString] ] )
        return YES;
    else
        return NO;
}

- (BOOL) checkIfIntegerValueOfStringA:(NSString*) stringA isEqualToIntegerValueOfStringB:(NSString*) stringB
{
    if ( [stringA integerValue] == [stringB integerValue] )
        return YES;
    else
        return NO;
}

- (BOOL) checkIfNumberValueOfStringA:(NSString*) stringA isEqualToNumberValueOfStringB:(NSString*) stringB
{
    if ( [@([stringA integerValue]) isEqualToNumber:@([stringB integerValue]) ])
        return YES;
    else
        return NO;
          
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == self.firstTextField) {
        [self.secondTextField becomeFirstResponder];
    } else if ( textField == self.secondTextField ) {
        [textField resignFirstResponder];
        // Custom code
        
        NSString* stringA = self.firstTextField.text;
        NSString* stringB = self.secondTextField.text;
        
        if ( [self checkIfStringA:stringA isEqualToStringB:stringB] )
            NSLog(@"The string values are equal");
        else
            NSLog(@"The string values are not equal");
        
        if ( [self checkIfLowercaseStringA:stringA isEqualToLowercaseStringB:stringB] )
            NSLog(@"The lowercase string values are equal");
        else
            NSLog(@"The lowercase string values are not equal");
        
        if ( [self checkIfIntegerValueOfStringA:stringA isEqualToIntegerValueOfStringB:stringB] )
            NSLog(@"The integer string values are equal");
        else
            NSLog(@"The integer string values are not equal");
        
        if ( [self checkIfNumberValueOfStringA:stringA isEqualToNumberValueOfStringB:stringB] )
            NSLog(@"The number string values are equal");
        else
            NSLog(@"The number string values are not equal");
    }
    
    return YES;
}

@end
