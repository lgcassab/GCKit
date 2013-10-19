//
//  UIWindow+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "UIWindow+GCKit.h"

@implementation UIWindow (GCKit)

- (UIView *)findFirstResponder {
	return [self findFirstResponderInView:self];
}

- (UIView *)findFirstResponderInView:(UIView *)topView {
	
	if ([topView isFirstResponder]) {
		return topView;
	}
	
	for (UIView *subView in topView.subviews) {
		if ([subView isFirstResponder]) {
			return subView;
		}
		
		UIView *firstResponderCheck = [self findFirstResponderInView:subView];
		if (nil != firstResponderCheck) {
			return firstResponderCheck;
		}
	}
	
	return nil;
}

@end
