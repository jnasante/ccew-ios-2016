//
//  BackViewController.m
//  Utility Application
//
//  Created by Philip Dow on 8/27/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "BackViewController.h"

@interface BackViewController ()

@end

@implementation BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ( self.text ) {
        // Check if text is nil because setting a label's text to nil causes a crash
        self.textLabel.text = self.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (IBAction)done:(id)sender
{
    [self.delegate backViewControllerDidFinish:self];
}

@end
