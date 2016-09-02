//
//  ViewController.m
//  Utility-From-Scratch
//
//  Created by Joseph Asante on 9/1/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"
#import "BackViewController.h"
#import "NibViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NibViewController alloc] initWithNibName:@"NibViewController" bundle:[NSBundle mainBundle]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //NSLog(@"Prepare for Segue: %@", segue.identifier);
    
    if ([segue.identifier  isEqualToString: @"backsideSegue"]) {
        NSLog(@"Backside Segue");
        
        BackViewController *controller = segue.destinationViewController;
        controller.test = @"Can you hear me now?";
        controller.delegate = self;
    }
}

- (void) backsideViewControllerDidFinish:(BackViewController *)controller options:(NSDictionary *)options {
    // should have email & password
    NSLog(@"Email: %@, Password: %@", options[@"email"], options[@"password"]);
}

@end
