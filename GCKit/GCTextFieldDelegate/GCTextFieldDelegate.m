//
//  GCTextFieldDelegate.m
//  tecnisa
//
//  Created by Gustavo Cassab on 25/08/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCTextFieldDelegate.h"
#import "UITextField+GCKit.h"
#import "NSString+GCKit.h"

static GCTextFieldDelegate *sharedDelegate;

@implementation GCTextFieldDelegate

+ (GCTextFieldDelegate *)sharedDelegate {
	static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedDelegate = [[GCTextFieldDelegate alloc] init];
    });
    return sharedDelegate;
}

- (id) init {
    return self;
}

+ (id)alloc {
	NSAssert(sharedDelegate == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    id maskDelegate = textField.maskDelegate;
    if (maskDelegate) {
        if ([maskDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
            return [maskDelegate textFieldShouldBeginEditing:textField];
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id maskDelegate = textField.maskDelegate;
    if (maskDelegate) {
        if ([maskDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
            [maskDelegate textFieldDidBeginEditing:textField];
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id maskDelegate = textField.maskDelegate;
    if (maskDelegate) {
        if ([maskDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
            return [maskDelegate textFieldShouldEndEditing:textField];
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id maskDelegate = textField.maskDelegate;
    if (maskDelegate) {
        if ([maskDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
            [maskDelegate textFieldDidEndEditing:textField];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *currentMask = textField.mask;
    
    // Aceita digitação apenas de numeros.
    NSString *regex = @"[0-9]*";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (! [regextest evaluateWithObject:string]) {
        return NO;
    }
    
    if ( ([currentMask isEqualToString:GCTextFieldMaskMoedaBrasileira]) || ([currentMask isEqualToString:GCTextFieldMaskMoedaAmericana]) ) {
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [formatter setFormatterBehavior: NSNumberFormatterBehavior10_4 ];
        [formatter setLocale:[NSLocale currentLocale]];
        [formatter setGeneratesDecimalNumbers:YES];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2];
        [formatter setAlwaysShowsDecimalSeparator:YES];
        if ([currentMask isEqualToString:GCTextFieldMaskMoedaBrasileira]) [formatter setCurrencySymbol:@"R$ "];
        if ([currentMask isEqualToString:GCTextFieldMaskMoedaAmericana])  [formatter setCurrencySymbol:@"U$ "];    
        
        NSString *stringNumber = nil;
        if ([string isEqualToString:@""]) {
            stringNumber = [textField.text substringToIndex:(textField.text.length -1)];
        } else {
            stringNumber = [NSString stringWithFormat:@"%@%@", textField.text, string];
        }
        
        stringNumber = [stringNumber stringWithNumbersOnly];
        NSNumber *number = [[NSNumber alloc] initWithDouble:([stringNumber doubleValue] / 100)];
        
        [textField setText:[formatter stringFromNumber:number]];
        
        return NO;
    }
    
    // Adiciona 9o dígito em caso do DDD ser de São Paulo.
    if ([currentMask isEqualToString:GCTextFieldMaskTelefone]) {
        if ([[textField text] length] >= 3) {
            NSString *ddd = [[textField text] substringWithRange:NSMakeRange(1,2)];
            NSArray *arrayDDD = @[@"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19"];
            if ([arrayDDD indexOfObject:ddd] != NSNotFound) {
                currentMask = @"(00) 00000-0000";
            }
        }
    }
    
    //If the length of used entered text is equals to mask length the user input must be cancelled
    if ([textField.text length] == [currentMask length]) {
        if(! [string isEqualToString:@""]) {
            return NO;
        } else {
            return YES;
        }
    }
    
    //If the user has started typing text on UITextField the formatting method must be called
    else if ([textField.text length] || range.location == 0) {
        
        if (string) {
            if(! [string isEqualToString:@""]) {
                [self formatInput:textField string:string range:range currentMask:currentMask];
                return NO;
            }
            
            { // Informa o usuário que o textField foi alterado.
                id maskDelegate = textField.maskDelegate;
                if (maskDelegate) {
                    if ([maskDelegate respondsToSelector:@selector(textFieldDidChange:)]) {
                        [maskDelegate performSelector:@selector(textFieldDidChange:) withObject:textField];
                    }
                }
            }
            
            return YES;
        }
        return YES;
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id maskDelegate = textField.maskDelegate;
    if (maskDelegate) {
        if ([maskDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
            return [maskDelegate textFieldShouldClear:textField];
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id maskDelegate = textField.maskDelegate;
    if (maskDelegate) {
        if ([maskDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
            return [maskDelegate textFieldShouldReturn:textField];
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

#pragma mark - Mask

- (void)formatInput:(UITextField*)aTextField string:(NSString*)aString range:(NSRange)aRange currentMask:(NSString *)currentMask {
    
    NSString* value = aTextField.text;
    NSString* formattedValue = value;
    
    aRange.length = 1;
    
    NSString* _mask = [currentMask substringWithRange:aRange];
    
    //Checking if there's a char mask at current position of cursor
    if (_mask != nil) {
        NSString *regex = @"[0-9]*";
        
        NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        //Checking if the character at this position isn't a digit
        if (! [regextest evaluateWithObject:_mask]) {
            //If the character at current position is a special char this char must be appended to the user entered text
            formattedValue = [formattedValue stringByAppendingString:_mask];
        }
        
        if (aRange.location + 1 < [currentMask length]) {
            _mask =  [currentMask substringWithRange:NSMakeRange(aRange.location + 1, 1)];
            if([_mask isEqualToString:@" "])
                formattedValue = [formattedValue stringByAppendingString:_mask];
        }
    }
    //Adding the user entered character
    formattedValue = [formattedValue stringByAppendingString:aString];
    
    //Refreshing UITextField value
    aTextField.text = formattedValue;
    
    { // Informa o usuário que o textField foi alterado.
        id maskDelegate = aTextField.maskDelegate;
        if (maskDelegate) {
            if ([maskDelegate respondsToSelector:@selector(textFieldDidChange:)]) {
                [maskDelegate performSelector:@selector(textFieldDidChange:) withObject:aTextField];
            }
        }
    }

}

@end
