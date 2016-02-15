//
//  JNATableViewController.m
//  CH8_Assignment1
//
//  Created by CCEW on 9/10/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNATableViewController.h"
#import "JNAPerson.h"
#import "JNAContactDetailViewController.h"
#import "JNAAddContactViewController.h"

@interface JNATableViewController ()

@property (strong, nonatomic) NSArray* items;
@property (strong, nonatomic) NSArray* contacts;

@end

@implementation JNATableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NSString* path = [[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"plist"];
    
    self.contacts = @[];
    
    /*self.items = [NSArray arrayWithContentsOfFile:[self addressBookPath]];
    [self convertToArrayOfPeople];*/
    
    //[self reloadAddressBook];
    
    NSArray* personsArray = [NSArray arrayWithContentsOfFile:[self addressBookPath]];
    
    for (NSDictionary* aDictionary in personsArray)
    {
        JNAPerson* person = [JNAPerson personWithDictionary:aDictionary];
        [[self mutableArrayValueForKey:@"contacts"] addObject:person];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
                                   
- (void) reloadAddressBook
{
    NSArray* personsArray = [NSArray arrayWithContentsOfFile:[self addressBookPath]];
                                   
    NSMutableArray* mutableContacts = [NSMutableArray array];
   
    for (NSDictionary* aDictionary in personsArray)
    {
       JNAPerson* person = [JNAPerson personWithDictionary:aDictionary];
       //[[self mutableArrayValueForKey:@"contacts"] addObject:person];
       [mutableContacts addObject:person];
    }
    
    self.contacts = mutableContacts;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Other Methods

- (void)addContact:(NSString*)firstName lastName:(NSString*)lastName phoneNumber:(NSString*)phoneNumber
{
    [[self mutableArrayValueForKey:@"contacts"] addObject:[JNAPerson personWithAllInfo:firstName lastName:lastName phoneNumber:phoneNumber]];
    
    [[self mutableArrayValueForKey:@"items"] addObject:@{@"firstname" : firstName, @"lastName" : lastName, @"phoneNumber" : phoneNumber}];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:[self.contacts count]-1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    /*NSError* error;
    
    [NSPropertyListSerialization propertyListWithData:self.contacts options:NSPropertyListImmutable format:NSPropertyListXMLFormat_v1_0 error:&error];*/
    

}
                                   
- (BOOL) savePersonsToAddressBook
                                   {
                                       BOOL success = [self.items writeToFile:[self addressBookPath] atomically:YES];
                                       
                                       return success;
                                   }

- (void)convertToArrayOfPeople
{
    for (int i = 0; i < [self.items count]; i++)
    {
        //[mutableContacts addObject:[JNAPerson personWithAllInfo:[self.items[i] valueForKey:@"firstName"] lastName:[self.items[i] valueForKey:@"lastName"] phoneNumber:[self.items[i] valueForKey:@"phoneNumber"]]];
        
        [[self mutableArrayValueForKey:@"contacts"] addObject:[JNAPerson personWithAllInfo:[self.items[i] valueForKey:@"firstName"] lastName:[self.items[i] valueForKey:@"lastName"] phoneNumber:[self.items[i] valueForKey:@"phoneNumber"]]];
    }
    
}

- (void) addContactViewControllerDidFinish:(JNAAddContactViewController *)aController options:(NSDictionary *)options
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self addContact:options[@"firstName"] lastName:options[@"lastName"] phoneNumber:options[@"phoneNumber"]];
}

- (NSString*) addressBookPath
{
    NSString* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString* addressBookPath = [documentsPath stringByAppendingPathComponent:@"AddressBook.plist"];
    
    return addressBookPath;
}

/*- (IBAction)addPerson:(id)sender
{
    JNAPerson* person = [[JNAPerson alloc] init];
    
    person.firstName = NSLocalizedString(@"unknown", nil);
    person.lastName = NSLocalizedString(@"unknown", nil);
    person.phoneNumber = NSLocalizedString(@"unknown", nil);
    
    [[self mutableArrayValueForKey:@"contacts" ] addObject:person];

}*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.contacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.contacts[indexPath.row] combineFirstAndLastNameIntoPresentableString];
    cell.detailTextLabel.text = [self.contacts[indexPath.row] phoneNumber];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[self mutableArrayValueForKey:@"contacts"] removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    BOOL success = [self savePersonsToAddressBook];
    
    if (!success)
    {
        NSLog(@"Unable to save contacts to %@", [self addressBookPath]);
    }

}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"addContactSegue"])
    {
        JNAAddContactViewController* viewController = [segue destinationViewController];
        viewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"contactDetailSegue"])
    {
        JNAContactDetailViewController* viewController = [segue destinationViewController];
        [viewController setName:[[(UITableViewCell*)sender textLabel] text]];
        [viewController setPhoneNumber:[[(UITableViewCell*)sender detailTextLabel] text]];

    }
    
}


@end
