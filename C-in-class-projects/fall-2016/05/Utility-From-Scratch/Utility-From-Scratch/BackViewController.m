//
//  BackViewController.m
//  Utility-From-Scratch
//
//  Created by Joseph Asante on 9/1/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "BackViewController.h"

@interface BackViewController ()

@end


@implementation BackViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.test);
    
    [self.emailTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [self loginUser];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.passwordTextField resignFirstResponder];
    }
    
    return YES;
}

-(void)loginUser {
    [self.delegate backsideViewControllerDidFinish:self options:@{
                                                                  @"email" : self.emailTextField.text,
                                                                  @"password" : self.passwordTextField.text
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
