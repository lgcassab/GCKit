//
//  GCTableCellLabelSubtitleHorizontal1.h
//  GCKit
//
//  Created by Gustavo Cassab on 14/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCTableCell.h"

@interface GCTableCellLabelSubtitleHorizontal1 : GCTableCell {
    
}

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle badgeText:(NSString *)badgeText;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle image:(UIImage *)image;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle image:(UIImage *)image badgeText:(NSString *)badgeText;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted badgeText:(NSString *)badgeText;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image badgeText:(NSString *)badgeText;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType badgeText:(NSString *)badgeText;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image badgeText:(NSString *)badgeText;

-(id)initWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image badgeText:(NSString *)badgeText;

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(int)tag accessoryView:(UIView *)aView;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(int)tag accessoryType:(UITableViewCellAccessoryType)aType;

@end
