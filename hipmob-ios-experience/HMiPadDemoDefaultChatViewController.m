//
//  HMiPhoneDemoDefaultChatViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPadDemoDefaultChatViewController.h"
#import "HMiPhoneConfig.h"
#import "hipmob/HMService.h"

@interface HMiPadDemoDefaultChatViewController ()
{
    HMChatPopoverController * popover;
}
@end

@implementation HMiPadDemoDefaultChatViewController

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
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)on_open_popover_demo:(id)sender
{
    [[HMService sharedService] openChatViewInPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem inDirection:UIPopoverArrowDirectionUp withSetup:^(HMChatPopoverController * controller){
        // save the popover: when using ARC this prevents the popover from being prematurely released
        popover = controller;
        
        // set the window title
        controller.content.title = @"Chat with an Operator";
        
        // set the popover content size
        if([controller.content respondsToSelector:@selector(setPreferredContentSize:)]){
            controller.content.preferredContentSize = CGSizeMake(320, 240);
        }else{
            // iOS6 and below
            controller.content.contentSizeForViewInPopover = CGSizeMake(320, 240);
        }
        
        // pass through: this lets us interact
        controller.passthroughViews = [[NSArray alloc] initWithObjects:self.view, nil];
    }];
}

- (IBAction)on_open_demo:(id)sender {
    // open a chat view
    [[HMService sharedService] openChatWithPush:self withSetup:^(HMContentChatViewController * controller){
        // set the title of the chat window
        controller.title = @"Chat with an Operator";
    }];
}
@end
