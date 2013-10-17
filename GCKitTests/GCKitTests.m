//
//  GCKitTests.m
//  GCKitTests
//
//  Created by Gustavo Cassab on 16/10/13.
//  Copyright (c) 2013 Gustavo Cassab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "GCKit.h"

@interface GCKitTests : XCTestCase

@end

@implementation GCKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCCP {
	CGPoint point = ccp(50, 150);
	XCTAssertFalse(CGPointEqualToPoint(point, CGPointZero), @"point can't be equals to CGPointZero");
	if (point.x != 50) XCTFail(@"point.x fail");
	if (point.y != 150) XCTFail(@"point.y fail");
}

- (void)testRGB {
	UIColor *color = RGB(150,150,150);
	XCTAssertNotNil(color, @"color can't be nil.");
	XCTAssertTrue([color isKindOfClass:[UIColor class]], @"color must be of UIColor class.");
}

- (void)testRGBA {
	UIColor *color = RGBA(150,150,150,1);
	XCTAssertNotNil(color, @"color can't be nil.");
	XCTAssertTrue([color isKindOfClass:[UIColor class]], @"color must be of UIColor class.");
}

- (void)testIPadDevice {
	NSInteger userInterfaceIdiom = UI_USER_INTERFACE_IDIOM();
	if (userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
		XCTAssertFalse(iPadDevice, @"userInterfaceIdiom must be iPhone");
	} else {
		XCTAssertTrue(iPadDevice, @"userInterfaceIdiom must be iPad");
	}
}

- (void)testAppVersion {
	NSString *appVersion = [[GCKit sharedKit] appVersion];
	XCTAssertNotNil(appVersion, @"appVersion can't be nil.");
	XCTAssertTrue([appVersion isKindOfClass:[NSString class]], @"appVersion must be of NSString class.");
	XCTAssertTrue(([appVersion length] > 0), @"appVersion must be longger than 0 chars.");
}

@end
