//
//  JNADetailViewController.m
//  CH5_Assignment3
//
//  Created by CCEW on 9/1/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNADetailViewController.h"

@interface JNADetailViewController ()
- (void)configureView;
@end

@implementation JNADetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
