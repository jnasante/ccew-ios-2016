//
//  FrontViewController.h
//  Utility Application
//
//  Created by Philip Dow on 8/27/15.
//  Copyright (c) 2015 Phil Dow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrontViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *otherLabel;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;


- (IBAction)flip:(id)sender;

@end

