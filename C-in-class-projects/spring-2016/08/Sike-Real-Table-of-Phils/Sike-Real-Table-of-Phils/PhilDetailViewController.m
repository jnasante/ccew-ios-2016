//
//  PhilDetailViewController.m
//  Sike-Real-Table-of-Phils
//
//  Created by Joseph Asante on 2/4/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "PhilDetailViewController.h"

@interface PhilDetailViewController ()

@end

@implementation PhilDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.philName.text = self.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
