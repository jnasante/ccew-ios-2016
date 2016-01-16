//
//  SCViewController.m
//  debug2
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (BOOL) textFieldShouldReturn:(UITextField *)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (IBAction)makeLowercase:(id)sender
{
  
    // Try setting a breakpoint here to see what's happening
    // Look at the class's instance variables
  
    NSString *text = self.textField.text;
    NSString *lowercase = [text lowercaseString];
    self.label.text = lowercase;
}


@end
