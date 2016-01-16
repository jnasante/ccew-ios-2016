//
//  ViewController.m
//  Assignment-01-06
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

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSString *text = textField.text;
    NSURL *URL = [NSURL URLWithString:text];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [self.webView loadRequest:request];
    
    return YES;
}

@end
