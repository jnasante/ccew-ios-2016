//
//  JNABookmarkCollectionViewController.h
//  CH7_Assignment2
//
//  Created by CCEW on 9/9/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNABookmarkCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray* bookmarks;

@end
