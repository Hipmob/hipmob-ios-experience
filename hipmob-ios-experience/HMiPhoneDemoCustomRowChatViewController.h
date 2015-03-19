//
//  HMiPhoneDemoCustomRowChatViewController.h
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 3/17/15.
//  Copyright (c) 2015 Orthogonal Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hipmob/HMService.h"

@interface HMiPhoneDemoCustomRowChatViewController : UIViewController <HMChatViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *opendemo;

- (IBAction)on_open_demo:(id)sender;

@end
