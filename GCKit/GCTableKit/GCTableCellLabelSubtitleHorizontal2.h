//
//  GCTableCellLabelSubtitleHorizontal2.h
//  GCKit
//
//  Created by Gustavo Cassab on 14/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCTableCell.h"

@interface GCTableCellLabelSubtitleHorizontal2 : GCTableCell {
    CGFloat textLabelWidth;
}
@property(nonatomic, readwrite)CGFloat textLabelWidth;

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

+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(NSUInteger)_tag;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(NSUInteger)_tag accessoryView:(UIView *)_accessoryView;
+(id)cellWithTitle:(NSString *)text subtitle:(NSString *)subtitle tag:(int)tag accessoryType:(UITableViewCellAccessoryType)aType;

-(id)initWithTitle:(NSString *)text subtitle:(NSString *)subtitle invertedLabels:(BOOL)inverted image:(UIImage *)image badgeText:(NSString *)badgeText;

@end
