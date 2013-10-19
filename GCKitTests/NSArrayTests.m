//
//  NSArrayTests.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+GCKit.h"

@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

- (void)testArrayWithBrazilianStates {
	NSArray *array = [NSArray arrayWithBrazilianStates];
	XCTAssertNotNil(array, @"array can't be nil.");
	XCTAssertTrue([array isKindOfClass:[NSArray class]], @"array must be of NSArray class.");
	if ([array count] != 27) {
		XCTFail(@"Brasilian States array must contain 27 registers. Found %d instead.", [array count]);
	}
}

@end
