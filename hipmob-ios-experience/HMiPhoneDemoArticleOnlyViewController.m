//
//  HMiPhoneDemoArticleOnlyViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPhoneDemoArticleOnlyViewController.h"
#import "HMiPhoneConfig.h"
#import "hipmob/HMService.h"

@interface HMiPhoneDemoArticleOnlyViewController ()

@end

@implementation HMiPhoneDemoArticleOnlyViewController

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
    [[HMService sharedService] openHelpdeskArticle:ARTICLEID fromCurrentView:self withSetup:^(HMHelpDeskArticleViewController * controller){
        // the title is set by default to the article title
        
        // disable the chat view
        controller.body.chatEnabled = HMContentHelpDeskArticleChatEnabledNever;
        
        controller.view.backgroundColor = [UIColor whiteColor];
    }];
}
@end
