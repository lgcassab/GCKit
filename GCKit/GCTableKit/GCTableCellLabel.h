//
//  GCTableCellLabel.h
//  GCKit
//
//  Created by Gustavo Cassab on 13/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCTableCell.h"

@interface GCTableCellLabel : GCTableCell {

}

+(id)cellWithText:(NSString *)text;
+(id)cellWithText:(NSString *)text tag:(NSUInteger)tag;
+(id)cellWithText:(NSString *)text badgeText:(NSString *)badgeText;
+(id)cellWithText:(NSString *)text image:(UIImage *)image;
+(id)cellWithText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText;
-(id)initWithText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText;

+(id)cellWithLargeText:(NSString *)text;
+(id)cellWithLargeText:(NSString *)text badgeText:(NSString *)badgeText;
+(id)cellWithLargeText:(NSString *)text image:(UIImage *)image;
+(id)cellWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText;
-(id)initWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText;
+(id)cellWithLargeText:(NSString *)text textLabelFont:(UIFont *)textLabelFont textLabelMaxWidth:(CGFloat)textLabelMaxWidth;

+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType;
+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType badgeText:(NSString *)badgeText;
+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image;
+(id)cellWithText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image badgeText:(NSString *)badgeText;

+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType;
+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType badgeText:(NSString *)badgeText;
+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image;
+(id)cellWithLargeText:(NSString *)text accessoryType:(UITableViewCellAccessoryType)aType image:(UIImage *)image badgeText:(NSString *)badgeText;

+(id)cellWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText textLabelFont:(UIFont *)textLabelFont textLabelMaxWidth:(CGFloat)textLabelMaxWidth;
-(id)initWithLargeText:(NSString *)text image:(UIImage *)image badgeText:(NSString *)badgeText textLabelFont:(UIFont *)textLabelFont textLabelMaxWidth:(CGFloat)textLabelMaxWidth;

+(id)cellWithText:(NSString *)text image:(UIImage *)image tag:(NSUInteger)tag;

@end
