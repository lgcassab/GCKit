//
//  GCActionFadeOut.m
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionFadeOut.h"

@implementation GCActionFadeOut {
	CGFloat d;
}

+ (id)actionWithDuration:(CGFloat)duration {
	return [[self alloc] initWithDuration:duration];
}

- (id)initWithDuration:(CGFloat)duration {
	
	d = duration;
	
	return self;
}

- (void)startWithTarget:(id)aTarget {
	
	[super startWithTarget:aTarget];
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setAlpha:'", [self.target class] ];
	NSAssert( [self.target respondsToSelector:@selector(setAlpha:)], warningMessage);
	
	[UIView beginAnimations:@"CGActionFadeOut" context:nil];
	[UIView setAnimationDidStopSelector:@selector(actionFinished)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:d];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];	
	[self.target setAlpha:0];
	[UIView commitAnimations];
}


@end
