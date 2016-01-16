//
//  ViewController.m
//  Assignment-02-03
//
//  Created by Philip Dow on 9/1/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import "ViewController.h"
#import "CCBusiness.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CCBusiness *business = [[CCBusiness alloc] init];
    
    business.name = @"Phil's Emporium";
    business.type = @"Misc.";
    business.phone = @"555-1234";
    
    business.street = @"415 Main Street";
    business.city = @"Norman";
    business.state = @"OK";
    business.zipcode = @"73001";
    
    NSLog(@"%@", business.name);
    NSLog(@"%@", business.type);
    
    // And so forth ...
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
