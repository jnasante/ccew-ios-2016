//
//  JNABookmarkCollectionViewController.m
//  CH7_Assignment2
//
//  Created by CCEW on 9/9/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNABookmarkCollectionViewController.h"
#import "JNABookmark.h"
#import "JNABookmarkDetailViewController.h"
#import "JNABookmarkCollectionViewCell.h"

@interface JNABookmarkCollectionViewController ()

@end

@implementation JNABookmarkCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

#pragma mark - Collection View Datasource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.bookmarks count];
}

- (JNABookmarkCollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JNABookmarkCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookmarkCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[JNABookmarkCollectionViewCell alloc] init];
        NSLog(@"%@", cell.reuseIdentifier);
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", [self.bookmarks[indexPath.row] name]];
    cell.websiteLabel.text = [NSString stringWithFormat:@"%@", [self.bookmarks[indexPath.row] websiteAddress]];
    
    NSLog(@"%d", indexPath.row);
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSString* name = [NSString stringWithFormat:@"%@", [[(JNABookmarkCollectionViewCell*)sender nameLabel] text]];
    NSString* url = [NSString stringWithFormat:@"%@", [[(JNABookmarkCollectionViewCell*)sender websiteLabel] text]];
    
    
    JNABookmarkDetailViewController* controller = [segue destinationViewController];
    [controller setName:name];
    [controller setUrl:url];
}


@end
