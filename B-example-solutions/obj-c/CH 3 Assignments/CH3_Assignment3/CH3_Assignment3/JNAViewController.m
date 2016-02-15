//
//  JNAViewController.m
//  CH3_Assignment3
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


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == self.firstTextField) {
        [self.secondTextField becomeFirstResponder];
    } else if ( textField == self.secondTextField ) {
        [textField resignFirstResponder];
        // Custom code
        
        self.firstText = self.firstTextField.text;
        self.secondText = self.secondTextField.text;
        
        self.label.text = [NSString stringWithFormat:@"%@ %@", self.firstText, self.secondText];
        
        NSLog(@"%@", self.label.text);
    }

    return YES;
}

@end
