//
//  FirstViewController.m
//  06-tabs
//
//  Created by Joseph Asante on 9/6/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITabBarItem *item = self.tabBarItem;
    item.badgeValue = @"asdfdslfjd";
    item.badgeValue = @"";
    
    UITabBarController *controller = self.tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
