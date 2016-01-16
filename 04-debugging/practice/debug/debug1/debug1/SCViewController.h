//
//  SCViewController.h
//  debug1
//
//  Created by Philip Dow on 1/16/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)done:(id)sender;
- (IBAction)splitString:(id)sender;

@end
