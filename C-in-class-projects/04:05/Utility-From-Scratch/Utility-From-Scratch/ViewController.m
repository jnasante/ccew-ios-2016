//
//  ViewController.m
//  Utility-From-Scratch
//
//  Created by Joseph Asante on 1/28/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"
#import "BacksideViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *test = @"blah";
    
    test = @"blegh";
    
    NSArray *testArray = @[ @"firstItem" ];
    NSLog(@"%@", testArray[1]);
    
    [self.usernameTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backsideViewControllerDidFinish:(BacksideViewController *)aController options:(NSDictionary *)options {
    NSLog(@"%@", options[@"wishes"]);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.usernameTextField) {
        [textField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"backsideSegue"]) {
        // do Something
        BacksideViewController *viewController = segue.destinationViewController;
        
        viewController.myString = @"My String";
        
        NSLog(@"I'm transitioning!");
    } else if ([segue.identifier isEqualToString:@"signInSegue"]) {
        BacksideViewController *viewController = segue.destinationViewController;
        
        viewController.email = self.usernameTextField.text;
        viewController.password = self.passwordTextField.text;
        
        viewController.delegate = self;
    }
}

@end
