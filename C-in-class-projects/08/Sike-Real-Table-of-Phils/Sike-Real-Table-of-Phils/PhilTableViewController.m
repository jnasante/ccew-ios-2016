//
//  PhilTableViewController.m
//  Sike-Real-Table-of-Phils
//
//  Created by Joseph Asante on 2/4/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import "PhilTableViewController.h"
#import "PhilTableViewCell.h"
#import "PhilDetailViewController.h"

@interface PhilTableViewController ()

@property (strong, nonatomic) NSArray *items;

@end

@implementation PhilTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.items = [[NSArray alloc] init];
    [self setValue:self.items forKey:@"items"];
    
    
    /*NSArray *array = @[@"blah", @2];
    
    NSMutableArray *mutableArray = [array mutableCopy];
    [mutableArray addObject:@3];
    array = [mutableArray copy];
    
    [self setValue:array forKey:@"array"];
    [[self mutableArrayValueForKey:@"array"] addObject:@3];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPhil:(id)sender {
    [[self mutableArrayValueForKey:@"items"] addObject:@(self.items.count-1)];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.items.count-1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhilTableViewCell *cell = (PhilTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.nameTextLabel.text = [NSString stringWithFormat:@"Phil number %ld", indexPath.row+1];
    cell.jobTextLabel.text =@"Software Developer";
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[self mutableArrayValueForKey:@"items"] removeObjectAtIndex:0];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"philDetail"]) {
        
        PhilDetailViewController *controller = (PhilDetailViewController*)segue.destinationViewController;
        
        controller.name = ((PhilTableViewCell*)sender).nameTextLabel.text;
    }
}


@end
