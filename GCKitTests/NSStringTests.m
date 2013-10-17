//
//  NSStringTests.m
//  GCKit
//
//  Created by Gustavo Cassab on 17/10/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+GCKit.h"

@interface NSStringTests : XCTestCase

@end

@implementation NSStringTests

- (void)testHeightForText {
	NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	CGFloat nHeight = [NSString heightForText:text withFont:[UIFont fontWithName:@"ArialMT" size:17.0f] constrainedToMaxWidth:300.0f];
	NSUInteger uHeight = fabs(nHeight);
	if (uHeight != 246) {
		XCTFail(@"text height should be 246");
	}
}

- (void)testSubstringWithStringBetweenStrings {
	NSString *text = @"Lorem ipsum dolor";
	NSString *substring = [NSString substringWithString:text between:@"Lorem" and:@"dolor"];
	XCTAssertNotNil(substring, @"substring can't be nil.");
	XCTAssertTrue([substring isKindOfClass:[NSString class]], @"substring must be of NSString class.");
	if (![substring isEqualToString:@" ipsum "]) {
		XCTFail(@"The substring should be ' ipsum ', but received '%@'", substring);
	}
}

- (void)testStringWithStringRepeat {
	NSString *text = [NSString stringWithString:@"t" repeat:5];
	XCTAssertNotNil(text, @"text can't be nil.");
	XCTAssertTrue([text isKindOfClass:[NSString class]], @"text must be of NSString class.");
	if (![text isEqualToString:@"ttttt"]) {
		XCTFail(@"The md5 should be 'ttttt', but received '%@'", text);
	}
}

- (void)testHeightWithFont {
	NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	CGFloat nHeight = [text heightWithFont:[UIFont fontWithName:@"ArialMT" size:17.0f] constrainedToMaxWidth:300.0f];
	NSUInteger uHeight = fabs(nHeight);
	if (uHeight != 246) {
		XCTFail(@"text height should be 246");
	}
}

- (void)testMD5 {
	NSString *text = @"This is my MD5 text";
	NSString *md5  = [text MD5];
	XCTAssertNotNil(md5, @"md5 can't be nil.");
	XCTAssertTrue([md5 isKindOfClass:[NSString class]], @"md5 must be of NSString class.");
	if (![md5 isEqualToString:@"c611c981fa65668e9b5819e9401e2b83"]) {
		XCTFail(@"The md5 should be 'c611c981fa65668e9b5819e9401e2b83', but received '%@'", md5);
	}
}

- (void)testStringWithNumbersOnly {
	NSString *text = @"This 1 is my 2 text with 3 numbers";
	NSString *numbersOnly = [text stringWithNumbersOnly];
	XCTAssertNotNil(numbersOnly, @"numbersOnly can't be nil.");
	XCTAssertTrue([numbersOnly isKindOfClass:[NSString class]], @"numbersOnly must be of NSString class.");
	if (![numbersOnly isEqualToString:@"123"]) {
		XCTFail(@"The numbersOnly should be '123', but received '%@'", numbersOnly);
	}
}

- (void)testStringWithoutAccentuation {
	NSString *text = @"Atenção para esta descrição com vários acentos.";
	NSString *noAccentuation = [text stringWithoutAccentuation];
	XCTAssertNotNil(noAccentuation, @"noAccentuation can't be nil.");
	XCTAssertTrue([noAccentuation isKindOfClass:[NSString class]], @"noAccentuation must be of NSString class.");
	if (![noAccentuation isEqualToString:@"Atencao para esta descricao com varios acentos."]) {
		XCTFail(@"The noAccentuation should be 'Atencao para esta descricao com varios acentos.', but received '%@'", noAccentuation);
	}
}

- (void)testReplaceHtmlEntitiesWithLatin1ISO8859 {
	NSString *text = @"This is my long text that will be truncated.";
	NSString *returnedText = [text replaceHtmlEntitiesWithLatin1ISO8859];
	XCTAssertNotNil(returnedText, @"returnedText can't be nil.");
	XCTAssertTrue([returnedText isKindOfClass:[NSString class]], @"returnedText must be of NSString class.");
}

- (void)testTruncateWithLenghtTail {
	
	NSString *text = @"This is my long text that will be truncated.";
	NSString *returnedText = [text truncateWithLength:15 tail:@"..."];
	XCTAssertNotNil(returnedText, @"returnedText can't be nil.");
	XCTAssertTrue([returnedText isKindOfClass:[NSString class]], @"returnedText must be of NSString class.");
	if (![returnedText isEqualToString:@"This is my long..."]) {
		XCTFail(@"The returnedText should be 'This is my long...', but received '%@'", returnedText);
	}
	
	NSString *otherReturnedText = [text truncateWithLength:15 tail:nil];
	XCTAssertNotNil(otherReturnedText, @"otherReturnedText can't be nil.");
	XCTAssertTrue([otherReturnedText isKindOfClass:[NSString class]], @"otherReturnedText must be of NSString class.");
	if (![otherReturnedText isEqualToString:@"This is my long"]) {
		XCTFail(@"The otherReturnedText should be 'This is my long', but received '%@'", returnedText);
	}
}

- (void)testDeleteLastCharacter {
	NSString *text = @"This is my text.";
	NSString *removedText  = [text deleteLastCharacter];
	XCTAssertNotNil(removedText, @"removedText can't be nil.");
	XCTAssertTrue([removedText isKindOfClass:[NSString class]], @"removedText must be of NSString class.");
	if (![removedText isEqualToString:@"This is my text"]) {
		XCTFail(@"The removedText should be 'This is my text', but received '%@'", removedText);
	}
}

- (void)testRemoveAllLineBreaksWithString {
	NSString *text = @"This\nis my\nbreak\nline\ntest.";
	NSString *returnedText = [text removeAllLineBreaksWithString:@" "];
	XCTAssertNotNil(returnedText, @"returnedText can't be nil.");
	XCTAssertTrue([returnedText isKindOfClass:[NSString class]], @"returnedText must be of NSString class.");
	if (![returnedText isEqualToString:@"This is my break line test."]) {
		XCTFail(@"The returnedText should be 'This is my break line test.', but received '%@'", returnedText);
	}
}

- (void)testRemoveAllLineBreaks {
	NSString *text = @"This \nis my\n break\n line\n test.";
	NSString *returnedText = [text removeAllLineBreaks];
	XCTAssertNotNil(returnedText, @"returnedText can't be nil.");
	XCTAssertTrue([returnedText isKindOfClass:[NSString class]], @"returnedText must be of NSString class.");
	if (![returnedText isEqualToString:@"This is my break line test."]) {
		XCTFail(@"The returnedText should be 'This is my break line test.', but received '%@'", returnedText);
	}
}

- (void)testCapitalizedFirstCharacterString {
	NSString *text = @"this is my text.";
	NSString *capitalizedText  = [text capitalizedFirstCharacterString];
	XCTAssertNotNil(capitalizedText, @"capitalizedText can't be nil.");
	XCTAssertTrue([capitalizedText isKindOfClass:[NSString class]], @"capitalizedText must be of NSString class.");
	if (![capitalizedText isEqualToString:@"This is my text."]) {
		XCTFail(@"The capitalizedText should be 'This is my text.', but received '%@'", capitalizedText);
	}
}

@end
