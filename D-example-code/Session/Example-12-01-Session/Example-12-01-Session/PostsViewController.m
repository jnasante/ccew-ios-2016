//
//  PostsViewController.m
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/24/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import "PostsViewController.h"
#import "PostsTableViewCell.h"
#import "Client+Posts.h"
#import "Post.h"

#import "NSArray+Functional_Utilities.h"

@interface PostsViewController ()

@property NSArray *posts;

@end

@implementation PostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Right bar button item
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(displayNewPostEditor:)];
    
    // Set up pull to refresh
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    // Immediately load the posts
    
    [self reloadPostsFromNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network communication

- (void) reloadPostsFromNetwork {
    [[Client sharedInstance] GETPosts:^(id data, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error GET /api/posts: %@", error);
            // Show the user
        } else {
            NSArray *postDictionaries = (NSArray*)data;
            NSLog(@"GET /api/posts: %@", postDictionaries);
            
            NSArray *postObjects = [postDictionaries map:^id(NSDictionary *dictionary, NSUInteger index) {
                return [[Post alloc] initWithDictionary:dictionary];
            }];
            
            NSLog(@"POST OBJECTS: %@", postObjects);
            
            self.posts = postObjects;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.titleLabel.text = ((Post*)self.posts[indexPath.row]).title;
    cell.authorLabel.text = [((Post*)self.posts[indexPath.row]).author stringValue];
    
    return cell;
}

#pragma mark - User Actions

- (IBAction)pullToRefresh:(id)sender {
    [self reloadPostsFromNetwork];
}

- (IBAction)displayNewPostEditor:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewPostEditor"];
    
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
