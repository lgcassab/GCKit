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
		XCTFail(@"Brazilian States array must contain 27 objects. Found %lu instead.", (unsigned long)[array count]);
	}
}

- (void)testSplitArrayWithRange {
	NSArray *array = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8)];
	
	NSArray *splitArray = [array splitWithRange:3];
	XCTAssertNotNil(splitArray, @"splitArray can't be nil.");
	XCTAssertTrue([splitArray isKindOfClass:[NSArray class]], @"splitArray must be of NSArray class.");
	XCTAssertEqual((NSInteger)[splitArray count], (NSInteger)3, @"splitArray should contain 3 objects");
	
	NSArray *split1 = splitArray[0];
	XCTAssertNotNil(split1, @"split1 can't be nil.");
	XCTAssertTrue([split1 isKindOfClass:[NSArray class]], @"split1 must be of NSArray class.");
	XCTAssertEqual((NSInteger)[split1 count], (NSInteger)3, @"split1 should contain 3 objects");
	XCTAssertEqual(split1[0] , @(1), @"objectAtIndex:0 should be @(1)");
	XCTAssertEqual(split1[1] , @(2), @"objectAtIndex:0 should be @(2)");
	XCTAssertEqual(split1[2] , @(3), @"objectAtIndex:0 should be @(3)");

	NSArray *split2 = splitArray[1];
	XCTAssertNotNil(split2, @"split2 can't be nil.");
	XCTAssertTrue([split2 isKindOfClass:[NSArray class]], @"split2 must be of NSArray class.");
	XCTAssertEqual((NSInteger)[split2 count], (NSInteger)3, @"split2 should contain 3 objects");
	XCTAssertEqual(split2[0] , @(4), @"objectAtIndex:0 should be @(4)");
	XCTAssertEqual(split2[1] , @(5), @"objectAtIndex:0 should be @(5)");
	XCTAssertEqual(split2[2] , @(6), @"objectAtIndex:0 should be @(6)");
	
	NSArray *split3 = splitArray[2];
	XCTAssertNotNil(split3, @"split3 can't be nil.");
	XCTAssertTrue([split3 isKindOfClass:[NSArray class]], @"split3 must be of NSArray class.");
	XCTAssertEqual((NSInteger)[split3 count], (NSInteger)2, @"split3 should contain 3 objects");
	XCTAssertEqual(split3[0] , @(7), @"objectAtIndex:0 should be @(7)");
	XCTAssertEqual(split3[1] , @(8), @"objectAtIndex:0 should be @(8)");
}

@end
