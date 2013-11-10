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

//- (UIView *)descendantOrSelfWithClass:(Class)cls; // Finds the first descendant view (including this view) that is a member of a particular class.

//- (UIView *)ancestorOrSelfWithClass:(Class)cls; // Finds the first ancestor view (including this view) that is a member of a particular class.

- (void)testViewWithKindOfClass {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	XCTAssertEqual([[view subviews] count], (NSUInteger)0, @"The number of subviews should be 0. Received %d instead.", [[view subviews] count]);
	
	UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 300, 40)];
	[view addSubview:subview];
	[view addSubview:label];
	XCTAssertEqual([[view subviews] count], (NSUInteger)2, @"The number of subviews should be 2. Received %d instead.", [[view subviews] count]);
	
	id test1 = [view viewWithKindOfClass:[UILabel class]];
	XCTAssertNotNil(test1, @"test1 should not be nil.");
	XCTAssertTrue([test1 isKindOfClass:[UILabel class]], @"test1 must be of UILabel class.");
}

- (void)testRemoveAllSubviews {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	XCTAssertEqual([[view subviews] count], (NSUInteger)0, @"The number of subviews should be 0. Received %d instead.", [[view subviews] count]);
	
	UIView *subview1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	UIView *subview2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	UIView *subview3 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[view addSubview:subview1];
	[view addSubview:subview2];
	[view addSubview:subview3];
	XCTAssertEqual([[view subviews] count], (NSUInteger)3, @"The number of subviews should be 3. Received %d instead.", [[view subviews] count]);
	
	[view removeAllSubviews];
	XCTAssertEqual([[view subviews] count], (NSUInteger)0, @"The number of subviews should be 0. Received %d instead.", [[view subviews] count]);
}

//- (CGPoint)offsetFromView:(UIView*)otherView; // Calculates the offset of this view from another view in screen coordinates. otherView should be a parent view of this view.

//- (UIViewController*)viewController; // The view controller whose view contains this view.

- (void)testRenderImage {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	UIImage *image = [view renderImage];
	XCTAssertNotNil(image, @"image should not be nil.");
	XCTAssertTrue([image isKindOfClass:[UIImage class]], @"image must be of UIImage class.");
	XCTAssertEqual(image.size.width, (CGFloat)50, @"image.size.width should be 50. Received %f instead.", image.size.width);
	XCTAssertEqual(image.size.height, (CGFloat)50, @"image.size.height should be 50. Received %f instead.", image.size.height);
}

- (void)testSubviewWithTag {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	XCTAssertEqual([[view subviews] count], (NSUInteger)0, @"The number of subviews should be 0. Received %d instead.", [[view subviews] count]);

	UIView *subview1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
	[subview1 setTag:123];
	[view addSubview:subview1];
	XCTAssertEqual([[view subviews] count], (NSUInteger)1, @"The number of subviews should be 1. Received %d instead.", [[view subviews] count]);
	
	UIView *subviewTagged = [view subviewWithTag:123];
	XCTAssertNotNil(subviewTagged, @"subviewTagged should not be nil.");
	XCTAssertTrue([subviewTagged isKindOfClass:[UIView class]], @"subviewTagged must be of UIView class.");
}

// Animate removing a view from its parent
//- (void)removeWithTransition:(UIViewAnimationTransition) transition andDuration:(float) duration;

// Animate adding a subview
//- (void)addSubview:(UIView *)view withTransition:(UIViewAnimationTransition) transition withDuration:(float) duration;

// Animate the changing of a views frame
//- (void)setFrame:(CGRect)fr withDuration:(float) duration;

// Animate changing the alpha of a view
//- (void)setAlpha:(float)a withDuration:(float) duration;

//- (UIColor *)colorAtPoint:(CGPoint)point;

@end
