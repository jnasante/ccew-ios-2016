//
//  JNABackSideViewController.h
//  CH4_Assignment1
//
//  Created by CCEW on 8/29/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JNABackSideProtocol;

@interface JNABackSideViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *petSegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *moreThanOneSwitch;
@property (weak, nonatomic) IBOutlet UISlider *cutenessSlider;

@property (weak) id<JNABackSideProtocol> delegate;

- (IBAction)dismiss:(id)sender;

@end

@protocol JNABackSideProtocol <NSObject>

- (void) backSideControllerDidFinish:(JNABackSideViewController*)aController options:(NSDictionary*)options;

@end
