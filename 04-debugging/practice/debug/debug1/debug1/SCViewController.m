//
//  SCViewController.m
//  debug1
//
//  Created by Philip Dow on 1/16/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCViewController.h"

@interface SCViewController ()

@end

@implementation SCViewController

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

- (IBAction)done:(id)sender
{
  [self.textView resignFirstResponder];
}

- (IBAction)splitString:(id)sender
{
  NSString *text = self.textView.text;
  NSArray *components = [text componentsSeparatedByString:@","];
  
  for ( NSInteger i = 0; i <= [components count]; i++ ) {
      
      NSString *item = [components objectAtIndex:i];
      NSString *stripped = [item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      
      NSLog(@"%@",stripped);
  }
}

@end
