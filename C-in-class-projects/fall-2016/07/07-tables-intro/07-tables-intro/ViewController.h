//
//  ViewController.h
//  07-tables-intro
//
//  Created by Joseph Asante on 9/8/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *reuseIdentifier;

@end

