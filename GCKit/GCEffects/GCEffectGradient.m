//
//  GCEffectGradient.m
//  GCKit
//
//  Created by Gustavo Cassab on 05/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCEffectGradient.h"

@implementation GCEffectGradient {
	UIColor *topColor;
	UIColor *bottomColor;
}

+ (id)gradientWithTopColor:(UIColor *)_topColor bottomColor:(UIColor *)_bottomColor {
	return [[self alloc]initWithTopColor:_topColor bottomColor:_bottomColor];
}

- (id)initWithTopColor:(UIColor *)_topColor bottomColor:(UIColor *)_bottomColor {
	
	topColor = _topColor;
	bottomColor = _bottomColor;
	
	return self;
}

- (void)runEffectInView:(UIView *)view {
	[super runEffectInView:view];
	
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = [self.target bounds];
	gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
	[[self.target layer] insertSublayer:gradient atIndex:0];
}

- (void)removeEffectFromView:(UIView *)view {
	[super removeEffectFromView:view];	
	
	CAGradientLayer *gradient = [[self.target layer].sublayers objectAtIndex:0];
	[gradient removeFromSuperlayer];
}

@end
