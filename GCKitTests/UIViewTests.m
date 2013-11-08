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

- (void)testSetLeft {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setLeft:10];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)10, @"Frame.origin.x should be 10. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead",
				   view.frame.size.height);
}

- (void)testTop {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.top, (CGFloat)50, @"View.top should be 50. Received %f instead.", view.top);
}

- (void)testSetTop {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setTop:10];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)10, @"Frame.origin.y should be 10. Received %f instead",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead",
				   view.frame.size.height);
}

- (void)testRight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.right, (CGFloat)100, @"View.right should be 100. Received %f instead.", view.right);
}

- (void)testSetRight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setRight:200];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)150, @"Frame.origin.x should be 150. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead",
				   view.frame.size.height);
}

- (void)testBottom {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.bottom, (CGFloat)100, @"View.bottom should be 100. Received %f instead.", view.bottom);
}

- (void)testSetBottom {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setBottom:250];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)200, @"Frame.origin.y should be 200. Received %f instead",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead",
				   view.frame.size.height);
}

- (void)testWidth {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.width, (CGFloat)50, @"View.width should be 50. Received %f instead.", view.width);
}

- (void)testSetWidth {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setWidth:230];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)230, @"Frame.size.width should be 230. Received %f instead.",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead",
				   view.frame.size.height);
}

- (void)testHeight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.height, (CGFloat)50, @"View.height should be 50. Received %f instead.", view.height);
}

- (void)testSetHeight {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setHeight:220];
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height,  (CGFloat)220, @"Frame.size.height should be 220. Received %f instead.",
				   view.frame.size.height);
}

- (void)testCenterX {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.centerX, (CGFloat)75, @"view.centerX should be 75. Received %f instead.", view.centerX);
}

- (void)testSetCenterX {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setCenterX:80];
	XCTAssertEqual(view.centerX, (CGFloat)80, @"view.centerX should be 55. Received %f instead.", view.centerX);
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)55, @"Frame.origin.x should be 55. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)50, @"Frame.origin.y should not be modified. Received %f instead",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead",
				   view.frame.size.height);
}

- (void)testCenterY {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.centerY, (CGFloat)75, @"view.centerY should be 75. Received %f instead.", view.centerY);
}

- (void)testSetCenterY {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setCenterY:80];
	XCTAssertEqual(view.centerY, (CGFloat)80, @"view.centerY should be 55. Received %f instead.", view.centerY);
	XCTAssertEqual(view.frame.origin.x,    (CGFloat)50, @"Frame.origin.x should not be modified. Received %f instead.",
				   view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y,    (CGFloat)55, @"Frame.origin.y should be 55. Received %f instead.",
				   view.frame.origin.y);
	XCTAssertEqual(view.frame.size.width,  (CGFloat)50, @"Frame.size.width should not be modified. Received %f instead",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"Frame.size.height should not be modified. Received %f instead",
				   view.frame.size.height);
}

- (void)testTTScreenX {
	UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 460)];
	UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[mainView addSubview:subview];
	XCTAssertEqual(subview.ttScreenX, (CGFloat)70, @"subview.ttScreenX should be 70. Received %f instead.", subview.ttScreenX);
}

- (void)testTTScreenY {
	UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 460)];
	UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[mainView addSubview:subview];
	XCTAssertEqual(subview.ttScreenY, (CGFloat)70, @"subview.ttScreenY should be 70. Received %f instead.", subview.ttScreenY);
}

- (void)testScreenViewX {
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[scrollView setContentSize:CGSizeMake(2000, 2000)];
	UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[scrollView addSubview:subview];
	[scrollView scrollRectToVisible:CGRectMake(200, 0, 320, 480) animated:NO];
	XCTAssertEqual(subview.screenViewX, (CGFloat)-150, @"subview.screenViewX should be -150. Received %f instead.", subview.screenViewX);
}

- (void)testScreenViewY {
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[scrollView setContentSize:CGSizeMake(2000, 2000)];
	UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[scrollView addSubview:subview];
	[scrollView scrollRectToVisible:CGRectMake(0, 200, 320, 480) animated:NO];
	XCTAssertEqual(subview.screenViewY, (CGFloat)-150, @"subview.screenViewY should be -150. Received %f instead.", subview.screenViewY);
}

- (void)testScreenFrame {
	// Return the view frame on the screen, taking into account scroll views.
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[scrollView setContentSize:CGSizeMake(2000, 2000)];
	UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[scrollView addSubview:subview];
	[scrollView scrollRectToVisible:CGRectMake(200, 200, 320, 480) animated:NO];
	XCTAssertEqual(subview.screenFrame.origin.x, (CGFloat)-150, @"subview.screenFrame.origin.x should be -150. Received %f instead.",
				   subview.screenFrame.origin.x);
	XCTAssertEqual(subview.screenFrame.origin.y, (CGFloat)-150, @"subview.screenFrame.origin.y should be -150. Received %f instead.",
				   subview.screenFrame.origin.y);
	XCTAssertEqual(subview.screenFrame.size.width,  (CGFloat)50, @"subview.screenFrame.width should not be modified. Received %f instead",
				   subview.screenFrame.size.width);
	XCTAssertEqual(subview.screenFrame.size.height, (CGFloat)50, @"subview.screenFrame.height should not be modified. Received %f instead",
				   subview.screenFrame.size.height);
}

- (void)testOrigin {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.frame.origin.x, (CGFloat)50, @"view.frame.origin.x should be 50. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y, (CGFloat)50, @"view.frame.origin.y should be 50. Received %f instead.", view.frame.origin.y);
}

- (void)testSetOrigin {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setOrigin:CGPointMake(80, 70)];
	XCTAssertEqual(view.frame.origin.x, (CGFloat)80, @"view.frame.origin.x should be 80. Received %f instead.", view.frame.origin.x);
	XCTAssertEqual(view.frame.origin.y, (CGFloat)70, @"view.frame.origin.y should be 70. Received %f instead.", view.frame.origin.y);
}

- (void)testSize {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	XCTAssertEqual(view.frame.size.width, (CGFloat)50, @"view.frame.size.width should be 50. Received %f instead.",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)50, @"view.frame.size.height should be 50. Received %f instead.",
				   view.frame.size.height);
}

- (void)testSetSize {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view setSize:CGSizeMake(80, 70)];
	XCTAssertEqual(view.frame.size.width, (CGFloat)80, @"view.frame.size.width should be 80. Received %f instead.",
				   view.frame.size.width);
	XCTAssertEqual(view.frame.size.height, (CGFloat)70, @"view.frame.size.height should be 70. Received %f instead.",
				   view.frame.size.height);
	
}

@end
