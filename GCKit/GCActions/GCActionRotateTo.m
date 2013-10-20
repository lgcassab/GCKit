//
//  GCActionRotateTo.m
//  GCKit
//
//  Created by Gustavo Cassab on 13/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionRotateTo.h"

@implementation GCActionRotateTo {
	CGFloat d;
	CGFloat a;
	
	UIViewAnimationCurve aCurve;
}

+ (id)actionWithDuration:(CGFloat)duration angle:(CGFloat)angle {
	return [[self alloc] initWithDuration:duration angle:angle animationCurve:UIViewAnimationCurveLinear ];
}

+ (id)actionWithDuration:(CGFloat)duration angle:(CGFloat)angle animationCurve:(UIViewAnimationCurve)animationCurve {
	return [[self alloc] initWithDuration:duration angle:angle animationCurve:animationCurve ];
}

- (id)initWithDuration:(CGFloat)duration angle:(CGFloat)angle animationCurve:(UIViewAnimationCurve)animationCurve {
	
	d = duration;
	a = angle;
	aCurve = animationCurve;
	
	return self;
}

- (void)startWithTarget:(id)aTarget {
	
	[super startWithTarget:aTarget];
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setTransform:'", [self.target class] ];
	NSAssert( [self.target respondsToSelector:@selector(setTransform:)], warningMessage);
	
	[UIView beginAnimations:@"CGKitRotateTo" context:nil];
	[UIView setAnimationDidStopSelector:@selector(actionFinished)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:d];
	[UIView setAnimationCurve:aCurve];	
	
	CGAffineTransform t;
	t = CGAffineTransformIdentity;
	t = CGAffineTransformMakeRotation(M_PI * (a) / 180.0);
	[(UIView *)self.target setTransform:t];
	
	[UIView commitAnimations];
	
}

@end
