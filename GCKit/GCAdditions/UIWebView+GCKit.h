//
//  UIWebView+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

@interface UIWebView (GCKit) {
	
}

// Gets the frame of a DOM element in the page.
// @query A JavaScript expression that evaluates to a single DOM element.
- (CGRect)frameOfElement:(NSString *)query;

@end
