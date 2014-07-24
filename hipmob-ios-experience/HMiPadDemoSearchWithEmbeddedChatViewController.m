//
//  HMiPhoneDemoSearchOnlyViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPadDemoSearchWithChatViewController.h"
#import "HMiPhoneConfig.h"
#import "hipmob/HMService.h"

@interface HMiPadDemoSearchWithChatViewController ()
{
    HMHelpDeskSearchPopoverController * popover;
    HMHelpDeskSearchViewController * search;
}
@end

@implementation HMiPadDemoSearchWithChatViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;

    if(search == nil){
        // Custom initialization
        search = [[HMHelpDeskSearchViewController alloc] initWithAppID:APPID andUser:nil andInfo:nil];
        [search didMoveToParentViewController:self];
        search.searchView.defaultQuery = @"ids:all";
        search.disableKeyboardAdjustment = YES;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
            search.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        search.body.navigationItem.hidesBackButton = YES;
        [self performSelector:@selector(removeSearchBackButton:) withObject:search afterDelay:0.25f];
    }
    // and load up the shared view into the container
    _container.autoresizesSubviews = YES;
    _container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    search.view.frame = _container.bounds;
    [_container addSubview:search.view];
}

-(void)removeSearchBackButton:(id)sender
{
    search.body.navigationItem.leftBarButtonItem = nil;
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
        if([controller.content respondsToSelector:@selector(setPreferredContentSize:)]){
            controller.content.preferredContentSize = CGSizeMake(320, 240);
        }else{
            // iOS6 and below
            controller.content.contentSizeForViewInPopover = CGSizeMake(320, 240);
        }
        
        // ensure that the chat button is only shown if an operator is available
        controller.content.chatEnabled = HMHelpDeskSearchChatEnabledAlways;
        
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
        
        // ensure that no chat window is shown
        //controller.chatEnabled = HMHelpDeskSearchChatEnabledNever;
        
        // set the search view tag filter: this will apply to all searches from this search view controller
        //controller.searchView.tagFilter = @"live chat";
        
        // sets the default query
        controller.searchView.defaultQuery = @"ids:all";
    }];
}
@end
