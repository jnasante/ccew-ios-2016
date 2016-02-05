//
//  ViewController.h
//  Table-Intro
//
//  Created by Joseph Asante on 2/4/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

