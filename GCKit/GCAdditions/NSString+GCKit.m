//
//  NSString+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 23/08/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "NSString+GCKit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (GCKit)

#pragma mark - Class Methods

+ (CGFloat)heightForText:(NSString *)text withFont:(UIFont *)font constrainedToMaxWidth:(CGFloat)maxWidth {
    
    if (!text)
        return 0;
    
    if (![text isKindOfClass:[NSString class]])
        return 0;
    
    CGFloat newHeight = 0;
    CGSize textSize   = CGSizeMake(0, 0);
    
    if (text) {
        if ([text length] > 0) {
			
			#ifndef __IPHONE_7_0
				textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
			#else
				textSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
			#endif
			
            newHeight = textSize.height;
        }
    }
    
    return newHeight;
}

+ (NSString *)substringWithString:(NSString *)string between:(NSString *)start and:(NSString *)end {
    string = [string substringFromIndex:([string rangeOfString:start].location + [start length])];
    if ([string rangeOfString:end].location != NSNotFound) {
        string = [string substringToIndex:[string rangeOfString:end].location];
    }
    return string;
}

+ (NSString *)stringWithString:(NSString *)text repeat:(NSUInteger)times {
    NSMutableString *result = [NSMutableString stringWithCapacity:[text length] * times];
    for (NSUInteger i = 0UL; i < times; ++i) {
        [result appendString:text];
    }
    return result;
}

#pragma mark - Public Methods

- (CGFloat)heightWithFont:(UIFont *)font constrainedToMaxWidth:(CGFloat)maxWidth {
    CGFloat newHeight = 0;
    CGSize textSize   = CGSizeMake(0, 0);
    
    if ([self length] > 0) {
		
        #ifndef __IPHONE_7_0
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        #else
        textSize = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        #endif
        
        newHeight = textSize.height;
    }
    
    return newHeight;
}

- (NSString *)MD5 {
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x",md5Buffer[i]];
	}
    return output;
}

// Remove all characters, returning only numbers.
- (NSString *)stringWithNumbersOnly {
    return [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
}

- (NSString *)stringWithoutAccentuation {
    NSData *data = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *stringTo = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return stringTo;
}

// Remove all HTML ISO-Latin from string
- (NSString *)replaceHtmlEntitiesWithLatin1ISO8859 {
    
    NSMutableString *temp = [NSMutableString stringWithString:self];
    
    [temp replaceOccurrencesOfString:@"&quot;"      withString:@"\"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&apos;"      withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&amp;"       withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&lt;"        withString:@"<" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&gt;"        withString:@">" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    
    [temp replaceOccurrencesOfString:@"&nbsp;"      withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&iexcl;"     withString:@"¡" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&cent;"      withString:@"¢" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&pound;"     withString:@"£" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&curren;"    withString:@"¤" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&yen;"       withString:@"¥" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&brvbar;"    withString:@"¦" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&sect;"      withString:@"§" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&uml;"       withString:@"¨" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&copy;"      withString:@"©" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ordf;"      withString:@"ª" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&laquo;"     withString:@"«" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&not;"       withString:@"¬" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&shy;"       withString:@""  options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&reg;"       withString:@"®" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&macr;"      withString:@"¯" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&deg;"       withString:@"°" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&plusmn;"    withString:@"±" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&sup2;"      withString:@"²" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&sup3;"      withString:@"³" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&acute;"     withString:@"´" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&micro;"     withString:@"µ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&para;"      withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&middot;"    withString:@"·" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&cedil;"     withString:@"¸" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&sup1;"      withString:@"¹" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ordm;"      withString:@"º" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&raquo;"     withString:@"»" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&frac14;"    withString:@"¼" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&frac12;"    withString:@"½" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&frac34;"    withString:@"¾" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&iquest;"    withString:@"¿" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&times;"     withString:@"×" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&divide;"    withString:@"÷" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    
    [temp replaceOccurrencesOfString:@"&Agrave;"    withString:@"À" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Aacute;"    withString:@"Á" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Acirc;"     withString:@"Â" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Atilde;"    withString:@"Ã" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Auml;"      withString:@"Ä" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Aring;"     withString:@"Å" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&AElig;"     withString:@"Æ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ccedil;"    withString:@"Ç" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Egrave;"    withString:@"È" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Eacute;"    withString:@"É" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ecirc;"     withString:@""  options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Euml;"      withString:@"Ë" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Igrave;"    withString:@"Ì" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Iacute;"    withString:@"Í" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Icirc;"     withString:@"Î" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Iuml;"      withString:@"Ï" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ETH;"       withString:@"Ð" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ntilde;"    withString:@"Ñ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ograve;"    withString:@"Ò" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Oacute;"    withString:@"Ó" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ocirc;"     withString:@"Ô" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Otilde;"    withString:@"Õ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ouml;"      withString:@"Ö" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Oslash;"    withString:@"Ø" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ugrave;"    withString:@"Ù" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Uacute;"    withString:@"Ú" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Ucirc;"     withString:@"Û" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Uuml;"      withString:@"Ü" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&Yacute;"    withString:@"Ý" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&THORN;"     withString:@"Þ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&szlig;"     withString:@"ß" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&agrave;"    withString:@"à" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&aacute;"    withString:@"á" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&acirc;"     withString:@"â" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&atilde;"    withString:@"ã" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&auml;"      withString:@"ä" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&aring;"     withString:@"å" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&aelig;"     withString:@"æ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ccedil;"    withString:@"ç" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&egrave;"    withString:@"è" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&eacute;"    withString:@"é" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ecirc;"     withString:@"ê" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&euml;"      withString:@"ë" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&igrave;"    withString:@"ì" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&iacute;"    withString:@"í" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&icirc;"     withString:@"î" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&iuml;"      withString:@"ï" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&eth;"       withString:@"ð" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ntilde;"    withString:@"ñ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ograve;"    withString:@"ò" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&oacute;"    withString:@"ó" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ocirc;"     withString:@"ô" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&otilde;"    withString:@"õ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ouml;"      withString:@"ö" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&oslash;"    withString:@"ø" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ugrave;"    withString:@"ù" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&uacute;"    withString:@"ú" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&ucirc;"     withString:@"û" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&uuml;"      withString:@"ü" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&yacute;"    withString:@"ý" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&thorn;"     withString:@"þ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&yuml;"      withString:@"ÿ" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];

    return [NSString stringWithString:temp];
}

- (NSString *)truncateWithLength:(NSInteger)maxLenght tail:(NSString *)tail {
    NSString *result = self;
    if (result.length > maxLenght) {
        result = [result substringWithRange:NSMakeRange(0, maxLenght)];
        result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        result = [NSString stringWithFormat:@"%@%@", result, (tail ? tail : @"")];
    }
    return result;
}

- (NSString *)deleteLastCharacter {
    NSMutableString *text = [NSMutableString stringWithString:self];
    [text deleteCharactersInRange:NSMakeRange(([self length] - 1), 1)];
    return text;
}

- (NSString *)removeAllLineBreaksWithString:(NSString *)text {
    NSString *code = [self stringByReplacingOccurrencesOfString:@"\n" withString:text];
	code = [code stringByReplacingOccurrencesOfString:@"\r" withString:text];
    return code;
}

- (NSString *)removeAllLineBreaks {
    return [self removeAllLineBreaksWithString:@""];
}

- (NSString *)capitalizedFirstCharacterString {
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                         withString:[[self substringToIndex:1] uppercaseString]];
}

@end
