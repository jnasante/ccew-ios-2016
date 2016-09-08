//
//  ViewController.m
//  06-navigation-from-scratch
//
//  Created by Joseph Asante on 9/6/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *compose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(compose:)];
    
    UINavigationItem *navItem = self.navigationItem;
    [navItem setRightBarButtonItem:compose];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
    NSLog(@"Editing");
}

- (IBAction)transition:(id)sender
{
    UIViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    [self.navigationController pushViewController:detail animated:YES];
    
    
}

- (IBAction)compose:(id)sender
{
    NSLog(@"Composing: Dear sir/madam: Hi.");
}

@end
