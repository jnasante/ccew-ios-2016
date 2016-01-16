//
//  FrontViewController.m
//  Utility Application
//
//  Created by Philip Dow on 8/27/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "FrontViewController.h"
#import "BackViewController.h"

@interface FrontViewController () <BackViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSString *text;

@end

@implementation FrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flip:(id)sender
{
    BackViewController *controller = (BackViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Back"];
    
    controller.delegate = self;
    
    // As long as we set properties before any method that causes the view to load,
    // they will be available in the controller's viewDidLoad method
    
    controller.text = self.text;
    
    // Set up modal presentation style and present
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Text Field Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    self.text = textField.text;
    [self flip:nil];
    
    return YES;
}

#pragma mark - Back View Controller Delegate

- (void) backViewControllerDidFinish:(BackViewController *)aController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
