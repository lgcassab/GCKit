//
//  NSString+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 23/08/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GCKit)

#pragma mark - Class Methods

+ (CGFloat)heightForText:(NSString *)text withFont:(UIFont *)font constrainedToMaxWidth:(CGFloat)maxWidth;
+ (NSString *)substringWithString:(NSString *)string between:(NSString *)start and:(NSString *)end;
+ (NSString *)stringWithString:(NSString *)text repeat:(NSUInteger)times;

#pragma mark - Public Methods

- (CGFloat)heightWithFont:(UIFont *)font constrainedToMaxWidth:(CGFloat)maxWidth;
- (NSString *)MD5;
- (NSString *)stringWithNumbersOnly;
- (NSString *)stringWithoutAccentuation;
- (NSString *)replaceHtmlEntitiesWithLatin1ISO8859;
- (NSString *)truncateWithLength:(NSInteger)maxLenght tail:(NSString *)tail;
- (NSString *)deleteLastCharacter;
- (NSString *)removeAllLineBreaksWithString:(NSString *)text;
- (NSString *)removeAllLineBreaks;
- (NSString *)capitalizedFirstCharacterString;

@end
