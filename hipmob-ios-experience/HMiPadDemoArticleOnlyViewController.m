//
//  HMiPhoneDemoArticleOnlyViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPadDemoArticleOnlyViewController.h"
#import "HMiPhoneConfig.h"
#import "hipmob/HMService.h"

@interface HMiPadDemoArticleOnlyViewController ()
{
    HMHelpDeskArticleViewPopoverController * popover;
}
@end

@implementation HMiPadDemoArticleOnlyViewController

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
    [[HMService sharedService] openHelpdeskArticleInPopover:ARTICLEID fromBarButtonItem:self.navigationItem.rightBarButtonItem inDirection:UIPopoverArrowDirectionUp withSetup:^(HMHelpDeskArticleViewPopoverController * controller){
        // save the popover: when using ARC this prevents the popover from being prematurely released
        popover = controller;
        
        // title is set by default to the article title.
        
        // set the popover content size
        if([controller.content respondsToSelector:@selector(setPreferredContentSize:)]){
            controller.content.preferredContentSize = CGSizeMake(320, 240);
        }else{
            // iOS6 and below
            controller.content.contentSizeForViewInPopover = CGSizeMake(320, 240);
        }
        
        // pass through: this lets us interact
        controller.passthroughViews = [[NSArray alloc] initWithObjects:self.view, nil];
        
        // disable the chat view
        controller.content.chatEnabled = HMHelpDeskArticleChatEnabledNever;
    }];
}

- (IBAction)on_open_demo:(id)sender {
    // open a search view controller
    [[HMService sharedService] openHelpdeskArticleWithPush:ARTICLEID fromCurrentView:self withSetup:^(HMContentHelpDeskArticleViewController * controller){
        // the title is set by default to the article title
        
        // disable the chat view
        //controller.chatEnabled = HMHelpDeskArticleChatEnabledNever;
    }];
}
@end
