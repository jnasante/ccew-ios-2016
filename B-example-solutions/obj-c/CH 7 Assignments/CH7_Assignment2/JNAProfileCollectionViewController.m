//
//  JNAProfileCollectionViewController.m
//  CH7_Assignment2
//
//  Created by CCEW on 9/9/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import "JNAProfileCollectionViewController.h"
#import "JNAProfile.h"
#import "JNAProfileDetailViewController.h"
#import "JNAProfileCollectionViewCell.h"

@interface JNAProfileCollectionViewController ()

@end

@implementation JNAProfileCollectionViewController

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
    
    _profiles = @[[JNAProfile profileWithInfo:@"Billy" lastName:@"Bob" emailAddress:@"billybob@ou.edu"],
                      [JNAProfile profileWithInfo:@"John" lastName:@"Vu" emailAddress:@"johnnyboy@ou.edu"],
                      [JNAProfile profileWithInfo:@"Joel" lastName:@"Reynolds" emailAddress:@"joel@ou.edu"],
                      [JNAProfile profileWithInfo:@"Joe" lastName:@"Williams" emailAddress:@"jojo@ou.edu"],
                      [JNAProfile profileWithInfo:@"Michael" lastName:@"Aaron" emailAddress:@"mike@ou.edu"],
                      [JNAProfile profileWithInfo:@"Cleatus" lastName:@"Hick" emailAddress:@"yeehaw@ou.edu"]
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
    return [self.profiles count];
}

- (JNAProfileCollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JNAProfileCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [self.profiles[indexPath.row] firstName], [self.profiles[indexPath.row] lastName]];
    cell.emailLabel.text = [NSString stringWithFormat:@"%@", [self.profiles[indexPath.row] emailAddress]];

    NSLog(@"%d", indexPath.row);
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSString* name = [NSString stringWithFormat:@"%@", [[(JNAProfileCollectionViewCell*)sender nameLabel] text]];
    NSString* email = [NSString stringWithFormat:@"%@", [[(JNAProfileCollectionViewCell*)sender emailLabel] text]];

    
    JNAProfileDetailViewController* controller = [segue destinationViewController];
    [controller setName:name];
    [controller setEmail:email];
}
*/

@end
