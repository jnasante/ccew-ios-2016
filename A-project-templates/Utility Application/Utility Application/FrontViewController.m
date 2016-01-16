//
//  FrontViewController.m
//  Utility Application
//
//  Created by Philip Dow on 8/27/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "FrontViewController.h"
#import "BackViewController.h"

@interface FrontViewController () <BackViewControllerDelegate>

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
    
    // Set up modal presentation style and present
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Back View Controller Delegate

- (void) backViewControllerDidFinish:(BackViewController *)aController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
