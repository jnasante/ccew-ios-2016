//
//  JNAContactDetailViewController.h
//  CH8_Assignment1
//
//  Created by CCEW on 9/11/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNAContactDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* phoneNumber;

@end
