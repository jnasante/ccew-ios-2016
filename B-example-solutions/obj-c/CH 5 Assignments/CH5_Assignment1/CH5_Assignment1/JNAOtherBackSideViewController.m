//
//  JNAOtherBackSideViewController.m
//  CH5_Assignment1
//
//  Created by CCEW on 9/1/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAOtherBackSideViewController.h"

@interface JNAOtherBackSideViewController ()

@end

@implementation JNAOtherBackSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender
{
    [self.delegate otherBackSideControllerDidFinish:self options:@{@"likeOrNot" : @(self.yesNoControl.selectedSegmentIndex)}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
