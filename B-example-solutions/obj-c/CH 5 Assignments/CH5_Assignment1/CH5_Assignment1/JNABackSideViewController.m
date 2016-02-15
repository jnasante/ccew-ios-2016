//
//  JNABackSideViewController.m
//  CH4_Assignment1
//
//  Created by CCEW on 8/29/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNABackSideViewController.h"

@interface JNABackSideViewController ()

@end

@implementation JNABackSideViewController

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
    
    [self.emailField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender
{
    [self.delegate backSideControllerDidFinish:self options:@{@"email" : self.emailField.text, @"password" : self.passwordField.text, @"pet" : @(self.petSegmentedControl.selectedSegmentIndex), @"moreThanOne" : @(self.moreThanOneSwitch.on), @"cuteness" : (NSNumber*)@(self.cutenessSlider.value * 100)}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.emailField)
        [self.passwordField becomeFirstResponder];
    else if (textField == self.passwordField)
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
