//
//  ViewController.m
//  Objects-Lesson
//
//  Created by Joseph Asante on 1/21/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

- (void) instanceMethod;
+ (void) classMethod;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BOOL yes = YES;
    NSInteger myint = 5;
    
    CGRect frame = CGRectMake(10, 83, 300, 300);
    
    CGPoint myPoint = CGPointMake(12, 50);
    
    myPoint.x = 5;
    myPoint.y = 4;
    
    myPoint.y = myPoint.x;
    
    [self resignFirstResponder];
    
    [[self view] resignFirstResponder];
    
    NSString *myString = @"fsdf";
    NSArray *array;
    
    float f = 1.4;
    int intFot = (int)f;
    
    UIButton *cell = [cell viewWithTag:101];
    
    UIButton *abutton = [self.button copy];
    
    self.objectTitle = @"I'm doing it";
    
    Person *person = [[Person alloc] initWithFirstName:@"Joseph" AndLastName:@"Asante"];
    NSLog(@"%@", person.firstName);
    
    Person *otherPerson = [Person personWithFirstName:@"Joseph" AndLastName:@"Asante"];
    
    NSString *blahf = [NSString stringWithFormat:@"blah"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doIt:(id)sender {
    NSString *otherTitle = self.objectTitle;
    NSInteger inte = 4;
    NSLog(@"%@", otherTitle);
}

@end
