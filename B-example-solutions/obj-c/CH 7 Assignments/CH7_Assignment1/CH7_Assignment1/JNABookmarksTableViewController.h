//
//  JNABookmarksTableViewController.h
//  CH7_Assignment1
//
//  Created by CCEW on 9/8/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNABookmarksTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* bookmarks;

@end
