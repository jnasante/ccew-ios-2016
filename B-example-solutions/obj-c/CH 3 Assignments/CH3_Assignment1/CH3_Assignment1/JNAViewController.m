//
//  JNAViewController.m
//  CH3_Assignment4
//
//  Created by CCEW on 8/27/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAViewController.h"
#import "SBCity.h"
#import "SBUSCity.h"

@interface JNAViewController ()

@end

@implementation JNAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SBCity* aCity;
    [aCity initWithCity:@"Accra"];
    aCity.country = @"Ghana";
    aCity.population = 23432233;
    aCity.latitude = 869.3;
    aCity.longitude = 234.5;
    
    SBUSCity* aUSCity;
    [aUSCity initWithCity:@"Weatherford" state:@"OK"];
    aUSCity.country = @"USA";
    aUSCity.population = "28839";
    aUSCity.latitude = 132.12;
    aUSCity.longitude = 432.23;
    
    NSLog(@"%@, %@\n%i people\n%f, %f", aCity.name, aCity.country, aCity.population, aCity.latitude, aCity.longitude);
    
    NSLog(@"%@, %@, %@\n%i people\n%f, %f", aUSCity.name, aUSCity.state, aUSCity.country, aUSCity.population, aUSCity.latitude, aUSCity.longitude);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
