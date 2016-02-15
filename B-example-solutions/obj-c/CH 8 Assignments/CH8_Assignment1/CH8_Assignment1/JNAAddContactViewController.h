//
//  JNAAddContactViewController.h
//  CH8_Assignment1
//
//  Created by CCEW on 9/11/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JNAAddContactProtocol;

@interface JNAAddContactViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak) id<JNAAddContactProtocol> delegate;

- (IBAction)dismiss:(id)sender;

@end

@protocol JNAAddContactProtocol <NSObject>

- (void) addContactViewControllerDidFinish:(JNAAddContactViewController*)aController options: (NSDictionary*)options;

@end