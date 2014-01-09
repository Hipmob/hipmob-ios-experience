//
//  HMiPhoneDemoDefaultChatViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPhoneDemoDefaultChatViewController.h"
#import "HMiPhoneConfig.h"
#import "hipmob/HMService.h"

@interface HMiPhoneDemoDefaultChatViewController ()

@end

@implementation HMiPhoneDemoDefaultChatViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)on_open_demo:(id)sender {
    // open a chat view
    [[HMService sharedService] openChat:self withSetup:^(HMChatViewController * controller){
        // set the title of the chat window
        controller.body.title = @"Chat with an Operator";
    }];
}
@end
