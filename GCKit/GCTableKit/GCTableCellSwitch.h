//
//  GCTableCellSwitch.h
//  GCKit
//
//  Created by Gustavo Cassab on 15/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCTableCell.h"

@interface GCTableCellSwitch : GCTableCell {
    UISwitch *switchControl;
}
@property (nonatomic, retain)UISwitch *switchControl;

+(id)cellWithText:(NSString *)text;
+(id)cellWithText:(NSString *)cellText switchIsOn:(BOOL)switchIsOn;
+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey;
+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey switchIsOn:(BOOL)switchIsOn;
-(id)initWithText:(NSString *)cellText dictionaryKey:(NSString *)dictKey switchIsOn:(BOOL)switchIsOn;

@end
