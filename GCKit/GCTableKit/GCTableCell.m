//
//  GCTableCell.m
//  GCKit
//
//  Created by Gustavo Cassab on 12/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCell.h"
#import "GCTableController.h"

@implementation GCTableCell
@synthesize tableController;
@synthesize height;
@synthesize badgeView;
@synthesize dictionaryKey;
@synthesize lockCellSelection;
@synthesize userObject;
@synthesize userObject2;
@synthesize userObject3;
@synthesize userObject4;
@synthesize userObject5;
@synthesize userID;
@synthesize userID2;
@synthesize userID3;
@synthesize userID4;
@synthesize userID5;
@synthesize userFlag;
@synthesize userFlag2;
@synthesize userFlag3;
@synthesize userFlag4;
@synthesize userFlag5;
@synthesize canEdit, editingStyle;
@synthesize hideBackgroundView;
@synthesize indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.tableController = nil;
        self.height = 44;
        
        self.dictionaryKey = nil;
		self.lockCellSelection = NO;
		
		self.canEdit = NO;
		self.editingStyle = UITableViewCellEditingStyleNone;
        
        badgeView = [[GCTableCellBadgeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		[self.contentView addSubview:badgeView];
		
		self.hideBackgroundView = NO;
        
        self.userFlag = NO;
        self.userFlag2 = NO;
        self.userFlag3 = NO;
        self.userFlag4 = NO;
        self.userFlag5 = NO;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	[self.badgeView setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self.badgeView setNeedsDisplay];
}

- (void)layoutSubviews {
	[super layoutSubviews];
   
    if(self.badgeView.text) {

		CGFloat margin = 10;
		CGSize badgeTextSize = [self.badgeView.text sizeWithFont:self.badgeView.font];
		CGFloat badgeHeight = badgeTextSize.height - 2;
		CGRect badgeFrame = CGRectMake(self.contentView.frame.size.width - (badgeTextSize.width+16) - margin, 
									   round((self.contentView.frame.size.height - badgeHeight)/2), 
									   badgeTextSize.width+16, badgeHeight); // must use "round" for badge to get correctly rendered
		self.badgeView.frame = badgeFrame;
		[self.badgeView setNeedsDisplay];
		
		// Resize textLabel
		if((self.textLabel.frame.origin.x + self.textLabel.frame.size.width) >= badgeFrame.origin.x) {
			CGFloat badgeWidth = self.textLabel.frame.size.width - badgeFrame.size.width - margin;
			
			self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, 
											  badgeWidth, self.textLabel.frame.size.height);
		}
		
		// Resize detailTextLabel
        if((self.detailTextLabel.frame.origin.x + self.detailTextLabel.frame.size.width) >= badgeFrame.origin.x) {
            CGFloat badgeWidth = self.detailTextLabel.frame.size.width - badgeFrame.size.width - margin;
            
            self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, 
                                                    badgeWidth, self.detailTextLabel.frame.size.height);
        }
	}
 
	if (hideBackgroundView) {
		[self setBackgroundColor:[UIColor clearColor]];			
		[self setBackgroundView:nil];
	}
}

- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	
	if(self.selectionStyle == UITableViewCellSelectionStyleNone) {
		self.textLabel.backgroundColor = color;
		self.detailTextLabel.backgroundColor = color;
	} else {
		self.textLabel.backgroundColor = [UIColor clearColor];
		self.detailTextLabel.backgroundColor = [UIColor clearColor];
	}
}

#pragma mark - Memory management

- (void)dealloc {
	
	if (dictionaryKey != nil) {
        [self.tableController.dictionaryKeyValues removeObjectForKey:dictionaryKey];
    }
	
    self.dictionaryKey = nil;
}

@end
