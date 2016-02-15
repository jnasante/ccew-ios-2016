//
//  JNATableViewController.h
//  CH8_Assignment1
//
//  Created by CCEW on 9/10/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JNAAddContactViewController.h"

@interface JNATableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, JNAAddContactProtocol>

- (void)addContact:(NSString*)firstName lastName:(NSString*)lastName phoneNumber:(NSString*)phoneNumber;

//- (IBAction)addPerson:(id)sender;

- (void)convertToArrayOfPeople;

@end
