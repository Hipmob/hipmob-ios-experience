//
//  HMiPhoneDemoCustomChatViewTableViewCell.h
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 3/18/15.
//  Copyright (c) 2015 Orthogonal Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hipmob/HMService.h"
#import "hipmob/HMChatMessage.h"

@interface HMiPhoneDemoCustomChatViewTableViewCell : UITableViewCell
{

}

+(CGFloat)heightForMessageRow:(HMChatMessage *)message withTableView:(UITableView *)tableView;

-(void)display:(HMChatMessage *)message inTableView:(UITableView *)tableView;
@end
