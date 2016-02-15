//
//  JNAViewController.h
//  CH4_Assignment1
//
//  Created by CCEW on 8/29/14.
//  Copyright (c) 2014 CCEW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNABackSideViewController.h"
#import "JNAOtherBackSideViewController.h"

@interface JNAViewController : UIViewController <JNABackSideProtocol, JNAOtherBackSideProtocol>

- (void) backSideControllerDidFinish:(JNABackSideViewController *)aController options:(NSDictionary *)options;

- (void) otherBackSideControllerDidFinish:(JNAOtherBackSideViewController *)aController options:(NSDictionary *)options;

@end
