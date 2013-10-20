//
//  GCActionMoveBy.m
//  GCKit
//
//  Created by Gustavo Cassab on 13/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionMoveBy.h"

@implementation GCActionMoveBy {
	CGFloat d;
	CGPoint p;
	
	UIViewAnimationCurve aCurve;
}

+ (id)actionWithDuration:(CGFloat)duration position:(CGPoint)position {
	return [[self alloc] initWithDuration:duration position:position animationCurve:UIViewAnimationCurveLinear];
}

+ (id)actionWithDuration:(CGFloat)duration position:(CGPoint)position animationCurve:(UIViewAnimationCurve)animationCurve {
	return [[self alloc] initWithDuration:duration position:position animationCurve:animationCurve];
}

- (id)initWithDuration:(CGFloat)duration position:(CGPoint)position animationCurve:(UIViewAnimationCurve)animationCurve {
	
	d = duration;
	p = position;
	aCurve = animationCurve;
	
	return self;
}

- (void)startWithTarget:(id)aTarget {
	
	[super startWithTarget:aTarget];
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setCenter:'", [self.target class] ];
	NSAssert( [self.target respondsToSelector:@selector(setCenter:)], warningMessage);
	
	CGFloat x, y;
	
	if (p.x == 0) 
		x = ( ([self.target frame].origin.x) + ([self.target frame].size.width / 2) );
	else
		x = ([(UIView *)self.target center].x + p.x);
	
	if (p.y == 0)
		y = ( ([self.target frame].origin.y) + ([self.target frame].size.height / 2) );
	else
		y = ([(UIView *)self.target center].y + p.y);
	
	[UIView beginAnimations:@"CGKitMoveBy" context:nil];
	[UIView setAnimationDidStopSelector:@selector(actionFinished)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:d];	
	[UIView setAnimationCurve:aCurve];	
	[self.target setCenter:CGPointMake(x, y)];
	[UIView commitAnimations];
}

- (GCAction *)reverse {
	return [[self class] actionWithDuration:d position:CGPointMake( -p.x, -p.y) animationCurve:aCurve];
}

@end
