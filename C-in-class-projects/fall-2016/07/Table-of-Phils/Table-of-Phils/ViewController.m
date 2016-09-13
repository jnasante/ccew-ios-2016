//
//  ViewController.m
//  Table-of-Phils
//
//  Created by Joseph Asante on 9/8/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.birthdateLabel.text = self.birthdate;
    NSLog(@"%@", self.birthdate);
    
    self.navigationItem.title = @"About Virtual Phil";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
