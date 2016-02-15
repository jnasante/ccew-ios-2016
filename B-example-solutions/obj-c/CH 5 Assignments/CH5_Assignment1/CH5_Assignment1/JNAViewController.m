//
//  JNAViewController.m
//  CH4_Assignment1
//
//  Created by CCEW on 8/29/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAViewController.h"
#import "JNABackSideViewController.h"

@interface JNAViewController ()

@end

@implementation JNAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"backSideSegue"] )
    {
        JNABackSideViewController* viewController = segue.destinationViewController;
        
        viewController.delegate = self;
        
        NSLog(@"prepareForSegue");
    }
    else
    {
        JNAOtherBackSideViewController* viewController = segue.destinationViewController;
        
        viewController.delegate = self;
        
        NSLog(@"otherBackSide");
    }
}

- (void) backSideControllerDidFinish:(JNABackSideViewController *)aController options:(NSDictionary *)options
{
    NSString* email = options[@"email"];
    NSString* password = options[@"password"];
    
    NSString* pet;
    if (options[@"pet"] == 0)
        pet = @"Dog";
    else
        pet = @"Cat";
    
    NSString* moreThanOne;
    if (options[@"moreThanOne"])
        moreThanOne = @"No";
    else
        moreThanOne = @"Yes";
    
    NSString* cuteness = [[NSString stringWithFormat:@"%@", options[@"cuteness"]] stringByAppendingString:@"%"];
    
    NSLog(@"email: %@\npassword: %@\npet: %@\nmore than one: %@\ncuteness: %@", email, password, pet, moreThanOne, cuteness);
}

- (void) otherBackSideControllerDidFinish:(JNAOtherBackSideViewController *)aController options:(NSDictionary *)options
{
    NSString* likeOrNot;
    
    if (options[@"likeOrNot"] == 0)
        likeOrNot = @"Yes";
    else
        likeOrNot = @"No";
    
    NSLog(@"Did user like it? %@", likeOrNot);
}

@end
