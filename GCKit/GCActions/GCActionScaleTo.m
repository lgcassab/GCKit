//
//  GCActionScaleTo.m
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionScaleTo.h"

@implementation GCActionScaleTo {
	CGFloat d;
	CGFloat s;
	
	UIViewAnimationCurve aCurve;
}

+ (id)actionWithDuration:(CGFloat)duration scale:(CGFloat)scale {
	return [[self alloc] initWithDuration:duration scale:scale animationCurve:UIViewAnimationCurveLinear];
}

+ (id)actionWithDuration:(CGFloat)duration scale:(CGFloat)scale animationCurve:(UIViewAnimationCurve)animationCurve {
	return [[self alloc] initWithDuration:duration scale:scale animationCurve:animationCurve];
}

- (id)initWithDuration:(CGFloat)duration scale:(CGFloat)scale animationCurve:(UIViewAnimationCurve)animationCurve {
	
	d = duration;
	s = scale;
	
	aCurve = animationCurve;
	
	return self;
}

- (void)startWithTarget:(id)aTarget {
	
	[super startWithTarget:aTarget];
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setTransform:'", [self.target class] ];
	NSAssert( [self.target respondsToSelector:@selector(setTransform:)], warningMessage);
	
	[UIView beginAnimations:@"CGActionScaleTo" context:nil];
	[UIView setAnimationDidStopSelector:@selector(actionFinished)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:d];	
	[UIView setAnimationCurve:aCurve];
	
	CGAffineTransform t;
	t = CGAffineTransformIdentity;
	t = CGAffineTransformScale(t, s, s);
	
	[(UIView *)self.target setTransform:t];
	[UIView commitAnimations];
}

@end
