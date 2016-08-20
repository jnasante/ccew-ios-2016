//
//  ViewController.h
//  Utility-From-Scratch
//
//  Created by Joseph Asante on 1/28/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BacksideViewController.h"

@interface ViewController : UIViewController <BacksideProtocol>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

