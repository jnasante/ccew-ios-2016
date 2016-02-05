//
//  PostsTableViewCell.h
//  Example-12-01-Session
//
//  Created by Philip Dow on 9/24/15.
//  Copyright © 2015 Phil Dow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@end
