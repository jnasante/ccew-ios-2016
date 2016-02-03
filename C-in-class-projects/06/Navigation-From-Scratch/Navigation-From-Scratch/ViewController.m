//
//  ViewController.m
//  Navigation-From-Scratch
//
//  Created by Joseph Asante on 2/2/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *compose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeAction:)];
    
    UINavigationItem *navItem = self.navigationItem;
    [navItem setRightBarButtonItem:compose];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)composeAction:(id)sender {
    // do stuff
    NSLog(@"composed message");
}

- (IBAction)transition:(id)sender {
    // transition
    UIViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondView"];
    [self.navigationController pushViewController:secondViewController animated:YES];
}

@end
