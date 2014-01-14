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

- (IBAction)clickButton1:(id)sender {
    NSLog(@"Click extra button 1");
}

- (IBAction)clickButton2:(id)sender {
    NSLog(@"Click extra button 2");
}

- (IBAction)on_open_popover_demo:(id)sender
{
    [[HMService sharedService] openChatViewInPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem inDirection:UIPopoverArrowDirectionUp withSetup:^(HMChatPopoverController * controller){
        // save the popover: when using ARC this prevents the popover from being prematurely released
        popover = controller;
        
        // set the window title
        controller.content.title = @"Chat with an Operator";
        
        // set the popover content size
        controller.popoverContentSize = CGSizeMake(320, 240);
        
        // hide the availability indicator
        //controller.content.hidesAvailabilityIndicator = YES;

        // pass through: this lets us interact
        controller.passthroughViews = [[NSArray alloc] initWithObjects:self.view, nil];
        
        // extra bar buttons
        UIBarButtonItem * one = [[UIBarButtonItem alloc] initWithTitle:@"One" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton1:)];
        UIBarButtonItem * two = [[UIBarButtonItem alloc] initWithTitle:@"Two" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton2:)];
        
        controller.content.extraBarButtonItems = @[one, two];
    }];
}

- (IBAction)on_open_demo:(id)sender {
    // open a chat view
    [[HMService sharedService] openChatWithPush:self withSetup:^(HMContentChatViewController * controller){
        // set the title of the chat window
        controller.title = @"Chat with an Operator";
        
        // no back button
        controller.navigationItem.hidesBackButton = YES;
        
        // extra bar buttons
        UIBarButtonItem * one = [[UIBarButtonItem alloc] initWithTitle:@"One" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton1:)];
        UIBarButtonItem * two = [[UIBarButtonItem alloc] initWithTitle:@"Two" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton2:)];
        
        controller.extraBarButtonItems = @[one, two];
    }];
}
@end
