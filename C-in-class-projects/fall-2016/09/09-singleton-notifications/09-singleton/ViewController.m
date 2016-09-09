//
//  ViewController.m
//  09-singleton
//
//  Created by Joseph Asante on 9/6/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"
#import "PersonManager.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initializeRandomStuff];
}

- (void) initializeRandomStuff
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddPerson:) name:PersonManagerCreatedPerson object:nil];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    PersonManager *manager = [PersonManager sharedInstance];
    [manager addPerson:[[Person alloc] init]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didAddPerson:(id)sender
{
    NSLog(@"Created Person");
}

@end
