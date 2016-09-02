//
//  BackViewController.h
//  Utility-From-Scratch
//
//  Created by Joseph Asante on 9/1/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BackViewController;

@protocol BacksideProtocol <NSObject>

- (void) backsideViewControllerDidFinish:(BackViewController*)controller options:(NSDictionary*)options;

@end

@interface BackViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSString *test;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak) id<BacksideProtocol> delegate;

@end


