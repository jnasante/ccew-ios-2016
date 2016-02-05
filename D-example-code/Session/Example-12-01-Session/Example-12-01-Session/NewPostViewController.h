//
//  NewPostViewController.h
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/24/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *bodyView;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)save:(id)sender;

@end
