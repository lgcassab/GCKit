//
//  GCCustomColoredAccessory.m
//  GCKit
//
//  Created by Gustavo Cassab on 21/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GCCustomColoredAccessory.h"

@implementation GCCustomColoredAccessory
@synthesize accessoryColor = _accessoryColor;
@synthesize highlightedColor = _highlightedColor;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (GCCustomColoredAccessory *)accessoryWithColor:(UIColor *)color {
    
	GCCustomColoredAccessory *ret = [[GCCustomColoredAccessory alloc] initWithFrame:CGRectMake(0, 0, 11.0, 15.0)];
	ret.accessoryColor = color;
    
	return ret;
}

+ (GCCustomColoredAccessory *)accessoryWithColor:(UIColor *)color highlightedColor:(UIColor *)newHighlightedColor {
    GCCustomColoredAccessory *ret = [[GCCustomColoredAccessory alloc] initWithFrame:CGRectMake(0, 0, 11.0, 15.0)];
	ret.accessoryColor   = color;
    ret.highlightedColor = newHighlightedColor;
	return ret;
}

- (void)drawRect:(CGRect)rect {
    
	// (x,y) is the tip of the arrow
	CGFloat x = CGRectGetMaxX(self.bounds)-3.0;;
	CGFloat y = CGRectGetMidY(self.bounds);
	const CGFloat R = 4.5;
	CGContextRef ctxt = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint(ctxt, x-R, y-R);
	CGContextAddLineToPoint(ctxt, x, y);
	CGContextAddLineToPoint(ctxt, x-R, y+R);
	CGContextSetLineCap(ctxt, kCGLineCapSquare);
	CGContextSetLineJoin(ctxt, kCGLineJoinMiter);
	CGContextSetLineWidth(ctxt, 3);
    
	if (self.highlighted) {
		[self.highlightedColor setStroke];
	} else {
		[self.accessoryColor setStroke];
	}
    
	CGContextStrokePath(ctxt);
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

- (UIColor *)accessoryColor {
    
	if (!_accessoryColor) {
		return [UIColor blackColor];
	}
    
	return _accessoryColor;
}

- (UIColor *)highlightedColo {
    
	if (!_highlightedColor) {
		return [UIColor whiteColor];
	}
    
	return _highlightedColor;
}

@end
