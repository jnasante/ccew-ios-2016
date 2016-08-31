//
//  ViewController.m
//  02-objects
//
//  Created by Joseph Asante on 8/25/16.
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
    
    int x = 3;
    int32_t y = 4;
    
    BOOL yesno = YES;
    NSInteger inte = 3;
    
    CGRect fram = CGRectMake(10, 30, 40, 20);
    CGPoint somePoint = CGPointMake(3, 4);
    
    somePoint.x = 4;
    somePoint.y = 5;
    
    NSString *                     something = @"cooltext";
//    NSArray * anArray = [NSArray arrayWithObjects:324, nil];
    
    self.inputViewController;
    
    
    [self inputViewController];
    
//    [self someAction:@"somecoolstring"];
//    
//    self.textField.text = @"blah";
//    [[self textField] text] = @"blah";
    
    [self someActionWithSomeString:@"someString" someOtherString:@"someOtherString"];
    
    // Nesting
    //[self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString@"htt.."]]];
    
    // instance vs. class
//    [Testclass classMethod]
//    Testclass *testClass = blah;
//    *testClass.instanceMethod;
    
    float niceFloat = 3.0;
    int niceInt = (int)niceFloat;
    
    UIButton *cell = (UIButton*)[self.view viewWithTag:101];
    
    id someObject;
    
    self.objectTitle = [NSString stringWithString:@"coolTitle"];
    
    // Objects
    Person* person = [[Person alloc] init];
    NSLog(@"%@", person.firstName);
    
    NSString* stringOne = [[NSString alloc] initWithString:@"blah"];
    
    Person* bob = [[Person alloc] initWithFirstName:@"Bob"];
    Person* alice = [Person personWithFirstName:@"Alice" lastName:@"Wunderlnd"];
    
    // Test of weakness
    self.weakString = [NSString stringWithFormat:@"I'm so weak"];
    NSLog(@"%@", self.weakString);
//    self.weakString = [NSString stringWithString:@"I'm so weak"];
//    self.weakString = @"I'm so weak";
    
    // Demonstrating pointers
    NSMutableString *firstString = [NSMutableString stringWithString:@"Some cool text"];
    NSMutableString *secondString = firstString;
    
    NSLog(firstString);
    NSLog(secondString);
    
    [firstString appendString:@" appended to some even cooler text"];
    
    NSLog(firstString);
    NSLog(secondString);
}

- (IBAction)showWeakness:(id)sender
{
    NSString *test = self.weakString;
    NSLog(@"%@",test);
}

- (void)someActionWithSomeString:(NSString*)someString someOtherString:(NSString*)otherString {
    //someAction:someString:otherString
    otherString = @"otherString";
    
}

//- (IBAction)selector:(id)sender {
//    
//}

- (IBAction)coolAction:(id)sender {
    NSString *title = self.objectTitle;
    NSLog(@"%@", title);
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    
}

//void someActionOtherStringSomeOtherString(String someString, String otherString){
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
