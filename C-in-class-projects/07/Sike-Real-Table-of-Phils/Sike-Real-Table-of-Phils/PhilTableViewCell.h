//
//  PhilTableViewCell.h
//  Sike-Real-Table-of-Phils
//
//  Created by Joseph Asante on 2/4/16.
//  Copyright © 2016 josephasante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhilTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *jobTextLabel;

- (IBAction)addPhil:(id)sender;

@end
