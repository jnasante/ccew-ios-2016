//
//  JNABookmarksTableViewController.m
//  CH7_Assignment1
//
//  Created by CCEW on 9/8/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNABookmarksTableViewController.h"
#import "JNABookmark.h"
#import "JNABookmarkTableViewCell.h"
#import "JNABookmarkViewController.h"

@interface JNABookmarksTableViewController ()

@end

@implementation JNABookmarksTableViewController

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
    
    self.bookmarks = @[[JNABookmark bookmarkWithInfo:@"Google" websiteAddress:@"http://www.google.com"],
                       [JNABookmark bookmarkWithInfo:@"Yahoo" websiteAddress:@"http://www.yahoo.com"],
                       [JNABookmark bookmarkWithInfo:@"OU" websiteAddress:@"http://www.ou.edu"],
                       [JNABookmark bookmarkWithInfo:@"D2L" websiteAddress:@"http://www.learn.ou.edu"],
                       [JNABookmark bookmarkWithInfo:@"Github" websiteAddress:@"http://github.com"],
                       [JNABookmark bookmarkWithInfo:@"Apple" websiteAddress:@"http://www.apple.com"],
                       [JNABookmark bookmarkWithInfo:@"Microsoft" websiteAddress:@"http://www.microsoft.com"]
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
    return [self.bookmarks count];
}


- (JNABookmarkTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JNABookmarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookmarkCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[JNABookmarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookmarkCell"];
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", [self.bookmarks[indexPath.row] name]];
    cell.websiteAddressLabel.text = [NSString stringWithFormat:@"%@", [self.bookmarks[indexPath.row] websiteAddress]];
    
    
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
    NSString* url = [[(JNABookmarkTableViewCell*)sender websiteAddressLabel] text];
    
    JNABookmarkViewController* controller = [segue destinationViewController];
    [controller setUrl:url];
}


#pragma mark - Table View Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
