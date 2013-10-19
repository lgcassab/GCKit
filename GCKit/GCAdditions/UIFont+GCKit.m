//
//  UIFont+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 21/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.

#import "UIFont+GCKit.h"

@implementation UIFont (GCKit)

- (CGFloat)lineHeight {
	return (self.ascender - self.descender) + 1;
}

@end
