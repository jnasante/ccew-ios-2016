//
//  DetailViewController.h
//  06-navigation
//
//  Created by Joseph Asante on 9/6/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

