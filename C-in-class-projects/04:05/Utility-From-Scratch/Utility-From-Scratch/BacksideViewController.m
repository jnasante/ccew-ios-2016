//
//  BacksideViewController.m
//  Utility-From-Scratch
//
//  Created by Joseph Asante on 1/28/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "BacksideViewController.h"

@interface BacksideViewController () <UITextFieldDelegate>

@end

@implementation BacksideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.myString);
    NSLog(@"%@", self.email);
    NSLog(@"%@", self.password);
    
    [self.wishesTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.wishesTextField) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)dismiss:(id)sender {
    [self.delegate backsideViewControllerDidFinish:self options:@{
                                                                  @"wishes" : self.wishesTextField.text
                                                                  }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
