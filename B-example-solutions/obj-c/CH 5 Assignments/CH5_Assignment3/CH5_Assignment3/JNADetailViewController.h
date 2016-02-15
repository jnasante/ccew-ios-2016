//
//  JNADetailViewController.h
//  CH5_Assignment3
//
//  Created by CCEW on 9/1/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNADetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
