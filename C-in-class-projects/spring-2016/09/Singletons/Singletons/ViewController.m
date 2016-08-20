//
//  ViewController.m
//  Singletons
//
//  Created by Joseph Asante on 2/9/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIApplication *app = [UIApplication sharedApplication];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(didCreateData:) name:DataManagerCreatedObject object:nil];
    
    NSLog(@"%@", [[DataManager sharedInstance] stuff]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didCreateData:(NSNotification*)aNotification
{
    NSString *notificationName = [aNotification name];
    NSDictionary *userInfo = [aNotification userInfo];
    id postingObject = [aNotification object];
    
    NSLog(@"%@", notificationName);
}

@end
