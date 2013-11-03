//
//  GCTableCellLabel.m
//  GCKit
//
//  Created by Gustavo Cassab on 13/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCellLabel.h"


@implementation GCTableCellLabel

#pragma mark -
#pragma mark Text


+(id)cellWithText:(NSString *)text {
    return [[self alloc]initWithText:text image:nil badgeText:nil];
}

+(id)cellWithText:(NSString *)text tag:(NSUInteger)tag {
	GCTableCellLabel *cell = [[self alloc]initWithText:text image:nil badgeText:nil];
	[cell setTag:tag];
	return cell;
}

+(id)cellWithText:(NSString *)text badgeText:(NSString *)badgeText {
    return [[self alloc]initWithText:text image:nil badgeText:badgeText];
}

+(id)cellWithText:(NSString *)text image:(UIImage *)image {
    return [[self alloc]initWithText:text image:image badgeText:nil];
}

+(id)cellWithText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText {
    return [[self alloc]initWithText:text image:image badgeText:badgeText];
}

+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType {
    GCTableCell *cell = [[self alloc]initWithText:text image:nil badgeText:nil];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType badgeText:(NSString *)badgeText {
    GCTableCell *cell = [[self alloc]initWithText:text image:nil badgeText:badgeText];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image {
    GCTableCell *cell = [[self alloc]initWithText:text image:image badgeText:nil];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image badgeText:(NSString *)badgeText {
    GCTableCell *cell = [[self alloc]initWithText:text image:image badgeText:badgeText];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithText:(NSString *)text image:(UIImage *)image tag:(NSUInteger)tag {
    GCTableCell *cell = [[self alloc]initWithText:text image:image badgeText:nil];
    [cell setTag:tag];
    return cell;
}


-(id)initWithText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText {
    if([self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
		[self.textLabel setText:text];
        
        if (image != nil)
            [self.imageView setImage:image];
        
        [self.badgeView setText:badgeText];
	}
	return self;
}

#pragma mark -
#pragma mark Large Text

+(id)cellWithLargeText:(NSString *)text {
    return [[self alloc]initWithLargeText:text image:nil badgeText:nil];
}

+(id)cellWithLargeText:(NSString *)text badgeText:(NSString *)badgeText {
    return [[self alloc]initWithLargeText:text image:nil badgeText:badgeText];
}

+(id)cellWithLargeText:(NSString *)text image:(UIImage *)image {
    return [[self alloc]initWithLargeText:text image:image badgeText:nil];
}

+(id)cellWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText {
    return [[self alloc]initWithLargeText:text image:image badgeText:badgeText];
}

+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType {
    GCTableCell *cell = [[self alloc]initWithLargeText:text image:nil badgeText:nil];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType badgeText:(NSString *)badgeText {
    GCTableCell *cell = [[self alloc]initWithLargeText:text image:nil badgeText:badgeText];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image {
    GCTableCell *cell = [[self alloc]initWithLargeText:text image:image badgeText:nil];
    [cell setAccessoryType:aType];
    return cell;
}

+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image badgeText:(NSString *)badgeText {
    GCTableCell *cell = [[self alloc]initWithLargeText:text image:image badgeText:badgeText];
    [cell setAccessoryType:aType];
    return cell;
}


-(id)initWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText {
    
    if([self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        
        if (image != nil)
            [self.imageView setImage:image];
        
        [self.badgeView setText:badgeText];
        
        [self.textLabel setText:text];
        [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.textLabel setNumberOfLines:0];
        
        {
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:19.0];
            CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
            CGSize labelSize = [text sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
            [self setHeight:( labelSize.height + 20) ];
        }
        
	}
    
	return self;
}

#pragma mark - LargeText and Custom textLabel width

+(id)cellWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText textLabelFont:(UIFont *)textLabelFont textLabelMaxWidth:(CGFloat)textLabelMaxWidth {
    return [[self alloc]initWithLargeText:text image:image badgeText:badgeText textLabelFont:textLabelFont textLabelMaxWidth:textLabelMaxWidth];
}

+(id)cellWithLargeText:(NSString *)text textLabelFont:(UIFont *)textLabelFont textLabelMaxWidth:(CGFloat)textLabelMaxWidth {
    return [[self alloc]initWithLargeText:text image:nil badgeText:nil textLabelFont:textLabelFont textLabelMaxWidth:textLabelMaxWidth];
    
}

-(id)initWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText textLabelFont:(UIFont *)textLabelFont textLabelMaxWidth:(CGFloat)textLabelMaxWidth {
    
    if([self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        
        if (image != nil)
            [self.imageView setImage:image];
        
        if (badgeText != nil)
            [self.badgeView setText:badgeText];
        
        [self.textLabel setText:text];
        [self.textLabel setFont:textLabelFont];
        [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.textLabel setNumberOfLines:0];
        
        {
            CGSize constraintSize = CGSizeMake(textLabelMaxWidth, MAXFLOAT);
            CGSize labelSize = [text sizeWithFont:textLabelFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
            [self setHeight:( labelSize.height + 20) ];
        }
        
	}
    return self;
}

@end
