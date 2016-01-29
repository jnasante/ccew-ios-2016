//
//  BacksideViewController.h
//  Utility-From-Scratch
//
//  Created by Joseph Asante on 1/28/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BacksideViewController;

@protocol BacksideProtocol <NSObject>

- (void) backsideViewControllerDidFinish:(BacksideViewController*)aController options:(NSDictionary*)options;

@end

@interface BacksideViewController : UIViewController

@property (weak) id <BacksideProtocol> delegate;

- (IBAction)dismiss:(id)sender;

@property (strong, nonatomic) NSString *myString;

@property (weak, nonatomic) IBOutlet UITextField *wishesTextField;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

@end


