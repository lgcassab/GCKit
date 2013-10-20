//
//  GCEffectBorder.m
//  GCKit
//
//  Created by Gustavo Cassab on 03/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCEffectBorder.h"

@implementation GCEffectBorder {
	UIColor *eColor;
	CGFloat eBorder;
}

+ (id)effect {
	return [[self alloc]initWithColor:[UIColor whiteColor] width:2];
}

+ (id)borderWithColor:(UIColor *)color width:(CGFloat)width {
	return [[self alloc]initWithColor:color width:width];
}

- (id)initWithColor:(UIColor *)color width:(CGFloat)width {
	
	eColor = color;
	eBorder = width;
	
	return self;
}

- (void)runEffectInView:(UIView *)view {
	[super runEffectInView:view];
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setBorderColor:'", [self.target class] ];
	NSAssert( [[self.target layer] respondsToSelector:@selector(setBorderColor:)], warningMessage);
	
	[[self.target layer] setBorderColor:[eColor CGColor]];
	[[self.target layer] setBorderWidth:eBorder];
}

- (void)removeEffectFromView:(UIView *)view {
	[super removeEffectFromView:view];	
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setBorderColor:'", [self.target class] ];
	NSAssert( [[self.target layer] respondsToSelector:@selector(setBorderColor:)], warningMessage);
	
	[[self.target layer] setBorderColor:[[UIColor clearColor] CGColor]];
	[[self.target layer] setBorderWidth:0];
}

@end
