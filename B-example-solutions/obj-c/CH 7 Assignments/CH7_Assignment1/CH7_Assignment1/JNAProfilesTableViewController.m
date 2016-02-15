//
//  JNAProfilesTableViewController.m
//  CH7_Assignment1
//
//  Created by CCEW on 9/8/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAProfilesTableViewController.h"
#import "JNAPerson.h"
#import "JNAProfileTableViewCell.h"
#import "JNAProfileViewController.h"

@interface JNAProfilesTableViewController ()

@end

@implementation JNAProfilesTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _profiles = @[[JNAPerson personWithInfo:@"Billy" lastName:@"Bob" emailAddress:@"billy.bob@ou.edu"],
                      [JNAPerson personWithInfo:@"John" lastName:@"Smith" emailAddress:@"johnnyboy@ou.edu"],
                      [JNAPerson personWithInfo:@"Joel" lastName:@"Reynolds" emailAddress:@"joel@ou.edu"],
                      [JNAPerson personWithInfo:@"Joe" lastName:@"Williams" emailAddress:@"jojo@ou.edu"],
                      [JNAPerson personWithInfo:@"Michael" lastName:@"Aaron" emailAddress:@"mike@ou.edu"],
                      [JNAPerson personWithInfo:@"Cleatus" lastName:@"Hicks" emailAddress:@"yeehaw@ou.edu"]
                      ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.profiles count];
}


- (JNAProfileTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JNAProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[JNAProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileCell"];
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [self.profiles[indexPath.row] firstName], [self.profiles[indexPath.row] lastName]];
    cell.emaillabel.text = [NSString stringWithFormat:@"%@", [self.profiles[indexPath.row] emailAddress]];
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    
    NSString* name = [[(JNAProfileTableViewCell*)sender nameLabel] text];
    NSString* email = [[(JNAProfileTableViewCell*)sender emaillabel] text];
    
    JNAProfileViewController* controller = [segue destinationViewController];
    [controller setName:name];
    [controller setEmail:email];
}


#pragma mark - Table View Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
