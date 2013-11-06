//
//  UIViewTests.m
//  GCKit
//
//  Created by Gustavo Cassab on 06/11/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+GCKit.h"

@interface UIViewTests : XCTestCase

@end

@implementation UIViewTests

#pragma mark - Position/Frame

- (void)testLeft {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.left, (CGFloat)50, @"View.left should be 50. Received %f instead.", view.left);
}

- (void)testTop {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.top, (CGFloat)50, @"View.top should be 50. Received %f instead.", view.top);
}

- (void)testWidth {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.width, (CGFloat)50, @"View.width should be 50. Received %f instead.", view.width);
}

- (void)testHeight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.height, (CGFloat)50, @"View.height should be 50. Received %f instead.", view.height);
}

- (void)testBottom {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.bottom, (CGFloat)100, @"View.bottom should be 100. Received %f instead.", view.bottom);
}

- (void)testRight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.right, (CGFloat)100, @"View.right should be 100. Received %f instead.", view.right);
}

- (void)testSetLeft {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setLeft:10];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)10, @"Frame.origin.x should be 10. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead", view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead", view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead", view.frame.size.height);
}

- (void)testSetTop {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setTop:10];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)10, @"Frame.origin.y should be 10. Received %f instead", view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead", view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead", view.frame.size.height);
}

- (void)testSetWidth {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setWidth:230];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead", view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)230, @"Frame.size.width should be 230. Received %f instead.", view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead", view.frame.size.height);
}

- (void)testSetHeight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setHeight:220];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead", view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead", view.frame.size.width);
	XCTAssertEqual(view.frame.size.height,  (CGFloat)220, @"Frame.size.height should be 220. Received %f instead.", view.frame.size.height);
}

- (void)testSetBottom {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setBottom:250];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)200, @"Frame.origin.y should be 200. Received %f instead", view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead", view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead", view.frame.size.height);
}

- (void)testSetRight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setRight:200];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)150, @"Frame.origin.x should be 150. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead", view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead", view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead", view.frame.size.height);
}

@end
