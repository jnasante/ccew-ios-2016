//
//  JNAAddContactViewController.m
//  CH8_Assignment1
//
//  Created by CCEW on 9/11/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAAddContactViewController.h"

@interface JNAAddContactViewController ()

@end

@implementation JNAAddContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.firstNameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender
{
    [self.delegate addContactViewControllerDidFinish:self options:@{@"firstName": self.firstNameTextField.text, @"lastName": self.lastNameTextField.text, @"phoneNumber": self.phoneNumberTextField.text}];

    self.firstNameTextField.text = @"";
    self.lastNameTextField.text = @"";
    self.phoneNumberTextField.text = @"";
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.firstNameTextField)
        [self.lastNameTextField becomeFirstResponder];
    else if (textField == self.lastNameTextField)
        [self.phoneNumberTextField becomeFirstResponder];
    else
        [textField resignFirstResponder];
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
