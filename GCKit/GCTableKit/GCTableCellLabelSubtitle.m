//
//  GCTableCellLabelSubtitle.m
//  GCKit
//
//  Created by Gustavo Cassab on 13/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCTableCellLabelSubtitle.h"


@implementation GCTableCellLabelSubtitle

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:nil];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle badgeText:(NSString *)badgeText {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:badgeText];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(NSUInteger)tag {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:nil badgeText:nil];
    [cell setTag:tag];
    return cell;
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle image:(UIImage *)image {
    return [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:image badgeText:nil];
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle image:(UIImage *)image tag:(NSUInteger)tag {
    GCTableCell *cell = [[self alloc]initWithTitle:text subtitle:subtitle invertedLabels:NO image:image badgeText:nil];
    [cell setTag:tag];
    return cell;
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

-(id)initWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image badgeText:(NSString *)badgeText {

    if([self initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil]) {
        
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

	}
    
	return self;
}

@end
