//
//  JNAViewController.h
//  CH3_Assignment3
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNAViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstTextField;

@property (weak, nonatomic) IBOutlet UITextField *secondTextField;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) NSString* firstText;

@property (strong, nonatomic) NSString* secondText;

- (BOOL) textFieldShouldReturn:(UITextField *)textField ;


@end
