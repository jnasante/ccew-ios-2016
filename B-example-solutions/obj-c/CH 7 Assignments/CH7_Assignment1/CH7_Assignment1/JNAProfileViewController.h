//
//  JNAProfileViewController.h
//  CH7_Assignment1
//
//  Created by CCEW on 9/8/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNAProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *emaillabel;

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* email;

@end
