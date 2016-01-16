//
//  ViewController.m
//  Assignment-01-03
//
//  Created by Philip Dow on 8/27/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// this is a UITextField delegate method
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{    
    // calling resignFirstResponder on the text field
    // and returning YES hides the keyboard
    [textField resignFirstResponder];
    self.label.text = textField.text;
    return YES;
}

@end
