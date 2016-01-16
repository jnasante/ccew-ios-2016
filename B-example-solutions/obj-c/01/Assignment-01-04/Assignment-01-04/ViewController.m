//
//  ViewController.m
//  Assignment-01-04
//
//  Created by Philip Dow on 8/28/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // You could set this property in interface builder
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // Look in Images.xcassets for the bokeh image
    self.imageView.image = [UIImage imageNamed:@"bokeh"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
