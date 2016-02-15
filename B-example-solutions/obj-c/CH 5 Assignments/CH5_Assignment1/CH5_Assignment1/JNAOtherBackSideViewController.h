//
//  JNAOtherBackSideViewController.h
//  CH5_Assignment1
//
//  Created by CCEW on 9/1/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JNAOtherBackSideProtocol;

@interface JNAOtherBackSideViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *yesNoControl;

@property (weak) id<JNAOtherBackSideProtocol> delegate;

- (IBAction)dismiss:(id)sender;

@end

@protocol JNAOtherBackSideProtocol <NSObject>

- (void) otherBackSideControllerDidFinish: (JNAOtherBackSideViewController*)aController options:(NSDictionary*)options;

@end
