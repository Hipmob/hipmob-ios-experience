//
//  HMiPhoneDemoCustomChatViewTableViewCell.m
//  hipmob-ios-experience
//
//  Created by Olufemi Omojola on 3/18/15.
//  Copyright (c) 2015 Orthogonal Labs, Inc. All rights reserved.
//

#import "HMiPhoneDemoCustomChatViewTableViewCell.h"

#define VERTICAL_MARGIN     5
#define HORIZONTAL_MARGIN   5
#define THUMBNAIL_SIZE      128
#define ICON_SIZE           48

static float OSV;
static UIFont * labelFont;

@interface HMiPhoneDemoCustomChatViewTableViewCell ()
{
    UIImageView * icon, * thumbnail;
}
@end

@implementation HMiPhoneDemoCustomChatViewTableViewCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (void)initialize
{
    OSV = [[[UIDevice currentDevice] systemVersion] floatValue];
    labelFont = nil;
}


+(CGFloat)heightForMessageRow:(HMChatMessage *)message withTableView:(UITableView *)tableView
{
    // profile picture is THUMBNAIL_SIZEpx
    // using a 2px margin below each row.
    // using a 5px margin on each side, and then 5px between the profile picture and the body
    CGFloat w = tableView.frame.size.width - HORIZONTAL_MARGIN - HORIZONTAL_MARGIN - HORIZONTAL_MARGIN - ICON_SIZE;
    CGFloat h = VERTICAL_MARGIN+ICON_SIZE;
    
    if(!labelFont){
        HMiPhoneDemoCustomChatViewTableViewCell * cell = [[HMiPhoneDemoCustomChatViewTableViewCell alloc] init];
        labelFont = cell.textLabel.font;
    }
    
    if([@"text" isEqualToString:message.subtype]){
        h = VERTICAL_MARGIN + [message.body sizeWithFont:labelFont constrainedToSize:CGSizeMake(w, 20000.0)].height;
        if(h < (VERTICAL_MARGIN+ICON_SIZE)) h = VERTICAL_MARGIN+ICON_SIZE;
    }else if([@"image" isEqualToString:message.subtype]){
        h = VERTICAL_MARGIN+THUMBNAIL_SIZE;
    }
    return h;
}

-(void)display:(HMChatMessage *)message inTableView:(UITableView *)tableView
{
    UIColor * bg = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
    // set the icon
    if([@"_" isEqualToString:message.remoteId]){
        [icon setImage:[UIImage imageNamed:@"man2.png"]];
        bg = [UIColor colorWithRed:222.0f/255.0f green:222.0f/255.0f blue:222.0f/255.0f alpha:1.0f];
    }else{
        [icon setImage:[UIImage imageNamed:@"man1.png"]];
    }
    icon.layer.cornerRadius = icon.frame.size.width / 2;
    
    if([@"text" isEqualToString:message.subtype]){
        [self.textLabel setText:message.body];
        [self.textLabel sizeToFit];
        self.textLabel.layer.cornerRadius = 5.0f;
        self.textLabel.hidden = NO;
        thumbnail.hidden = YES;
        self.textLabel.layer.backgroundColor = bg.CGColor;
    }else if([@"image" isEqualToString:message.subtype]){
        // custom display for images
        NSString * thumbfile = [HMService resolvePath:[[message attributes] valueForKey:@"thumbfile"] forMessage:message];
        UIImage * image = [UIImage imageNamed:@"imageplaceholder"];
        if([[NSFileManager defaultManager] fileExistsAtPath:thumbfile]){
            image = [UIImage imageWithContentsOfFile:thumbfile];
        }
        [thumbnail setImage:image];
        thumbnail.layer.cornerRadius = 5.0f;
        thumbnail.layer.backgroundColor = bg.CGColor;
        thumbnail.hidden = NO;
        self.textLabel.hidden = YES;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 0;
        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        icon = [[UIImageView alloc] init];
        icon.translatesAutoresizingMaskIntoConstraints = NO;
        icon.clipsToBounds = YES;
        [self.contentView addSubview:icon];
        
        thumbnail = [[UIImageView alloc] init];
        thumbnail.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:thumbnail];
        
        NSDictionary *metrics = @{@"hmargin":@HORIZONTAL_MARGIN, @"vmargin":@VERTICAL_MARGIN, @"iconsize":@ICON_SIZE, @"thumbnailsize":@THUMBNAIL_SIZE};
        NSDictionary *views = @{ @"bodyLabel": self.textLabel, @"icon": icon, @"imageView": thumbnail };
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hmargin-[icon(==iconsize)]-[bodyLabel]-hmargin-|" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hmargin-[icon(==iconsize)]-[imageView(==thumbnailsize)]" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vmargin-[icon(==iconsize)]" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vmargin-[bodyLabel]" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vmargin-[imageView(==thumbnailsize)]" options:0 metrics:metrics views:views]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.textLabel.frame);
}

@end