//
//  GCTableCellLabelSubtitleHorizontal2.m
//  GCKit
//
//  Created by Gustavo Cassab on 14/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCellLabelSubtitleHorizontal2.h"
#import "UIView+GCKit.h"

@implementation GCTableCellLabelSubtitleHorizontal2
@synthesize textLabelWidth;

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:nil];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle badgeText:(NSString *)badgeText {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:badgeText];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle image:(UIImage *)image {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:image badgeText:nil];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle image:(UIImage *)image badgeText:(NSString *)badgeText {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:image badgeText:badgeText];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:inverted image:nil badgeText:nil];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted badgeText:(NSString *)badgeText {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:inverted image:nil badgeText:badgeText];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:inverted image:image badgeText:nil];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image badgeText:(NSString *)badgeText {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:inverted image:image badgeText:badgeText];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:nil];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType badgeText:(NSString *)badgeText {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:badgeText];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:image badgeText:nil];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image badgeText:(NSString *)badgeText {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:image badgeText:badgeText];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(NSUInteger)_tag {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:nil];
    [cell setTag:_tag];
    return cell;
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(NSUInteger)_tag accessoryView:(UIView *)_accessoryView {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:nil];
    [cell setTag:_tag];
    [cell setAccessoryView:_accessoryView];
    return cell;
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(int)tag accessoryType:(UITableViewCellAccessoryType)aType {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:nil];
    [cell setAccessoryType:aType];
    [cell setTag:tag];
    return cell;
}

-(id)initWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image badgeText:(NSString *)badgeText {
    
	self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    if(self) {
        
        if (image != nil)
            [self.imageView setImage:image];
        
        [self.badgeView setText:badgeText];
        
        [self.textLabel setText:text];
        [self.detailTextLabel setText:subtitle];
        
        if (inverted) {
            [self.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
            [self.textLabel setTextColor:[UIColor grayColor]];
            
            [self.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
            [self.detailTextLabel setTextColor:[UIColor blackColor]];
        }
        
		self.textLabelWidth = 67;
	}
    
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (textLabelWidth != 67) {
		CGRect aFrame = self.textLabel.frame;
		[self.textLabel setFrame:CGRectMake(aFrame.origin.x, aFrame.origin.y, textLabelWidth, aFrame.size.height)];
		[self.detailTextLabel setLeft:aFrame.origin.x + textLabelWidth +10 ];
	}
}

@end
