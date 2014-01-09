//
//  HMiPhoneDemoArticleViewOptionsViewController.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 1/8/14.
//  Copyright (c) 2014 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPhoneDemoArticleViewOptionsViewController.h"

@interface HMiPhoneDemoArticleViewOptionsViewController ()
@property (nonatomic, strong) NSMutableArray *menuItems;
@end

@implementation HMiPhoneDemoArticleViewOptionsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _menuItems = [[NSMutableArray alloc] initWithCapacity:10];

    [_menuItems addObject:@"articleonly"];
    
    //[_menuItems addObject:@"articlewithlivechat"];
    
    //[_menuItems addObject:@"articleinreveal"];
    
    //[_menuItems addObject:@"articlewithcustomlivechat"];
    
    //[_menuItems addObject:@"articlewithlivechatoperator"];
    
    //[_menuItems addObject:@"articlewithcustomtoolbar"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)tableCell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * opt = (NSString *)[self.menuItems objectAtIndex:[indexPath row]];
    if([@"articleonly" isEqualToString:opt]){
        [self performSegueWithIdentifier:@"articleonly" sender:self];
    }
}
@end
