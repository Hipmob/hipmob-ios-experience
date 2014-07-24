//
//  HMiPhoneDemoSearchOnlyViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPhoneDemoSearchWithChatViewController.h"
#import "HMiPhoneConfig.h"
#import "hipmob/HMService.h"

@interface HMiPhoneDemoSearchWithChatViewController ()

@end

@implementation HMiPhoneDemoSearchWithChatViewController

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
    // open a search view controller
    [[HMService sharedService] openHelpdeskSearch:self withSetup:^(HMHelpDeskSearchViewController * controller){
        // set the title of the window
        controller.body.title = @"Help Search";
        
        // ensure that a chat window is always shown
        controller.chatEnabled = HMHelpDeskSearchChatEnabledAlways;
        
        // sets the default query
        controller.searchView.defaultQuery = @"ids:all";
    } forApp:APPID];
}
@end
