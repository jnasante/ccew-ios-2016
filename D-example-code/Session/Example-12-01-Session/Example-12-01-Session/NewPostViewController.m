//
//  NewPostViewController.m
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/24/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import "NewPostViewController.h"
#import "Client+Posts.h"
#import "Post.h"

@interface NewPostViewController ()

@end

@implementation NewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)save:(id)sender {
    
    NSString *title = self.titleField.text;
    NSString *body = self.bodyView.text;
    
    // Would confirm that a title and body have been set
    
    Post *post = [[Post alloc] init];
    post.title = title;
    post.body = body;
    post.author = @(1);
    
    NSDictionary *postDictionary = [[post dictionaryRepresentation] dictionaryWithValuesForKeys:@[@"title", @"body", @"author"]];
    
    [[Client sharedInstance] POSTPost:postDictionary completionHandler:^(id data, NSHTTPURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"There was an error saving the post");
            // Show the user
        } else {
            NSDictionary *postDictionary = (NSDictionary*)data;
            NSLog(@"%@", postDictionary);
            
            Post *post = [[Post alloc] initWithDictionary:postDictionary];
            NSLog(@"%@", post);
            
            // Would let interested parties know that a post has been created
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
