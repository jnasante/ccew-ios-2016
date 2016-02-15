//
//  JNAViewController.h
//  CH3_Assignment4
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNAViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstTextField;

@property (weak, nonatomic) IBOutlet UITextField *secondTextField;

- (BOOL) checkIfStringA:(NSString*)stringA isEqualToStringB:(NSString*)stringB;

- (BOOL) checkIfLowercaseStringA:(NSString*)stringA isEqualToLowercaseStringB:(NSString*)stringB;

- (BOOL) checkIfIntegerValueOfStringA:(NSString*) stringA isEqualToIntegerValueOfStringB:(NSString*) stringB;

- (BOOL) checkIfNumberValueOfStringA:(NSString*) stringA isEqualToNumberValueOfStringB:(NSString*) stringB;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
