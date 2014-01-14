//
//  HMiPhoneDemoSearchOnlyViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPadDemoSearchWithChatIfOperatorAvailableViewController.h"
#import "HMiPhoneConfig.h"
#import "hipmob/HMService.h"

@interface HMiPadDemoSearchWithChatIfOperatorAvailableViewController ()
{
    HMHelpDeskSearchPopoverController * popover;
}
@end

@implementation HMiPadDemoSearchWithChatIfOperatorAvailableViewController

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

- (IBAction)on_open_popover_demo:(id)sender {
    [[HMService sharedService] openHelpdeskSearchInPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem inDirection:UIPopoverArrowDirectionUp withSetup:^(HMHelpDeskSearchPopoverController * controller){
        // save the popover: when using ARC this prevents the popover from being prematurely released
        popover = controller;
        
        // set the window title
        controller.content.title = @"Help Search";
        
        // set the popover content size
        controller.popoverContentSize = CGSizeMake(320, 240);
        
        // ensure that the chat button is only shown if an operator is available
        controller.content.chatEnabled = HMHelpDeskSearchChatEnabledIfOperatorAvailable;
        
        // pass through: this lets us interact
        controller.passthroughViews = [[NSArray alloc] initWithObjects:self.view, nil];
        
        // sets the default query
        controller.content.searchView.defaultQuery = @"ids:all";
    }];
}

- (IBAction)on_open_demo:(id)sender {
    // open a search view controller
    [[HMService sharedService] openHelpdeskSearchWithPush:self withSetup:^(HMContentHelpDeskSearchViewController * controller){
        // set the title of the window
        controller.title = @"Help Search";
        
        // make sure we'll not be covered by the bars
        if([controller respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
            controller.edgesForExtendedLayout = UIRectEdgeNone;
            controller.extendedLayoutIncludesOpaqueBars = YES;
        }
        
        // hide the back button
        controller.navigationItem.hidesBackButton = YES;
        
        // ensure that no chat window is shown
        controller.chatEnabled = HMContentHelpDeskSearchChatEnabledIfOperatorAvailable;

        // set the search view tag filter: this will apply to all searches from this search view controller
        //controller.searchView.tagFilter = @"live chat";
        
        // sets the default query
        controller.searchView.defaultQuery = @"ids:all";
    }];
}
@end
