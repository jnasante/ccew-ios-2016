//
//  ViewController.h
//  Assignment-02-01
//
//  Created by Philip Dow on 9/1/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) NSString *myTitle;

- (IBAction)setTheString:(id)sender;

@end

