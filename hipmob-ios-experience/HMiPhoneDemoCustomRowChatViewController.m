//
//  HMiPhoneDemoCustomRowChatViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 3/17/15.
//  Copyright (c) 2015 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPhoneDemoCustomRowChatViewController.h"
#import "HMiPhoneConfig.h"
#import "HMiPhoneDemoCustomChatViewTableViewCell.h"

NSString * const CustomRowClass = @"CustomRowClass";

@interface HMiPhoneDemoCustomRowChatViewController ()

@end

@implementation HMiPhoneDemoCustomRowChatViewController

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

- (IBAction)on_open_demo:(id)sender
{
    // open a chat view controller
    [[HMService sharedService] openChat:self withSetup:^(HMChatViewController * controller){
        // set the delegate
        controller.chatDelegate = self;
        
        // register the cell for the display: this lets us use the existing table view cell caching mechanisms
        [[controller.chatView table] registerClass:[HMiPhoneDemoCustomChatViewTableViewCell class] forCellReuseIdentifier:CustomRowClass];
    } forApp:APPID];
}

-(CGFloat)chatViewController:(id)chatViewController heightForMessageRow:(HMChatMessage *)message withTableView:(UITableView *)tableView
{
    return [HMiPhoneDemoCustomChatViewTableViewCell heightForMessageRow:message withTableView:tableView];
}

- (UITableViewCell *)chatViewController:(id)chatViewController cellForMessageRow:(HMChatMessage *)message withTableView:(UITableView *)tableView
{
    HMiPhoneDemoCustomChatViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomRowClass];
    [cell display:message inTableView:tableView];
    return cell;
}

- (void)chatViewController:(id)chatViewController didSelectMessage:(HMChatMessage *)message
{
    if([@"image" isEqualToString:message.subtype]){
        NSString * thumbfile = [HMService resolvePath:[message.attributes valueForKey:@"thumbfile"] forMessage:message];
        NSString * imagefile = [HMService resolvePath:[message.attributes valueForKey:@"file"] forMessage:message];
        if(!thumbfile || ![[NSFileManager defaultManager] fileExistsAtPath:thumbfile]){
            // fetch the thumb
            [HMService downloadThumb:message];
        }else if(!imagefile || ![[NSFileManager defaultManager] fileExistsAtPath:imagefile]){
            [HMService downloadImage:message];
        }else{
            // display the full size image: imagefile is the path
        }
    }
}

@end
