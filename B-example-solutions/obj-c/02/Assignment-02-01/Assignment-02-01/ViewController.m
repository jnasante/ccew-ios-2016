//
//  ViewController.m
//  Assignment-02-01
//
//  Created by Philip Dow on 9/1/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myTitle = @"Some String I Set";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setTheString:(id)sender
{
    self.titleLabel.text = self.myTitle;
}

@end
