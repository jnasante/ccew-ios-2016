//
//  PhilTableViewCell.h
//  Table-of-Phils
//
//  Created by Joseph Asante on 9/8/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhilTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;

@end
