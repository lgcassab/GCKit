//
//  UIWindow+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

@interface UIWindow (GCKit) {
	
}

// Searches the view hierarchy recursively for the first responder, starting with this window.
- (UIView *)findFirstResponder;

// Searches the view hierarchy recursively for the first responder, starting with topView.
- (UIView *)findFirstResponderInView:(UIView *)topView;

@end
