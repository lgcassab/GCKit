//
//  GCEffectShadowTrapezoidal.m
//  GCKit
//
//  Created by Gustavo Cassab on 03/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCEffectShadowTrapezoidal.h"

@implementation GCEffectShadowTrapezoidal {
	UIColor *shadowColor;
	CGFloat shadowOpacity;
	CGSize  shadowOffset;
	CGFloat shadowRadius;
}

+ (id)effect {
	return [[self alloc]initWithColor:[UIColor blackColor] opacity:0.7f offset:CGSizeMake(0.0f, 10.0f) radius:5.0f];
}

+ (id)shadowWithColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius {
	return [[self alloc]initWithColor:color opacity:opacity offset:offset radius:radius];
}

- (id)initWithColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius {
	
	shadowColor = color;
	shadowOpacity = opacity;
	shadowOffset = offset;
	shadowRadius = radius;
	
	return self;
}

- (void)runEffectInView:(UIView *)view {
	[super runEffectInView:view];
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setShadowColor:'", [self.target class] ];
	NSAssert( [[self.target layer] respondsToSelector:@selector(setShadowColor:)], warningMessage);
	
	[[self.target layer] setShadowColor:[shadowColor CGColor]];
	[[self.target layer] setShadowOpacity:shadowOpacity];
	[[self.target layer] setShadowOffset:shadowOffset];
	[[self.target layer] setShadowRadius:shadowRadius];
	[[self.target layer] setMasksToBounds:NO];
	
	CGSize size = [self.target bounds].size;
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(size.width * 0.33f, size.height * 0.66f)];
	[path addLineToPoint:CGPointMake(size.width * 0.66f, size.height * 0.66f)];
	[path addLineToPoint:CGPointMake(size.width * 1.15f, size.height * 1.15f)];
	[path addLineToPoint:CGPointMake(size.width * -0.15f, size.height * 1.15f)];
	
	[[self.target layer] setShadowPath:[path CGPath]];
}

- (void)removeEffectFromView:(UIView *)view {
	[super removeEffectFromView:view];	
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setShadowColor:'", [self.target class] ];
	NSAssert( [[self.target layer] respondsToSelector:@selector(setShadowColor:)], warningMessage);
	
	[[self.target layer] setShadowColor:[[UIColor clearColor] CGColor]];
	[[self.target layer] setShadowOpacity:0.0f];
	[[self.target layer] setShadowOffset:CGSizeMake(0.0f, 0.0f)];
	[[self.target layer] setShadowRadius:0.0f];
	[[self.target layer] setShadowPath:nil];
}

@end
