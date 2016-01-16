//
//  ViewController.m
//  Assignment-01-02
//
//  Created by Philip Dow on 8/27/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getTheDate:(id)sender {
    // Called when Get the date is pressed
    
    NSDate *today = [NSDate date];
    self.label.text = [today description];
}

@end
