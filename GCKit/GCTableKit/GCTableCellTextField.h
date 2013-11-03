//
//  GCTableCellTextField.h
//  GCKit
//
//  Created by Gustavo Cassab on 16/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCTableCell.h"

@interface GCTableCellTextField : GCTableCell <UITextFieldDelegate> {
    UITextField *textField;
}
@property (nonatomic, retain)UITextField *textField;

+(id)cellWithText:(NSString *)text;
+(id)cellWithText:(NSString *)text textFieldValue:(NSString *)textFieldValue;
+(id)cellWithText:(NSString *)text textFieldValue:(NSString *)textFieldValue placeholder:(NSString *)placeholder;

+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey;
+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey textFieldValue:(NSString *)textFieldValue;
+(id)cellWithText:(NSString *)text dictionaryKey:(NSString *)dictKey textFieldValue:(NSString *)textFieldValue placeholder:(NSString *)placeholder;

-(id)initWithText:(NSString *)cellText dictionaryKey:(NSString *)dictKey textFieldValue:(NSString *)textFieldValue placeholder:(NSString *)placeholder;

@end
