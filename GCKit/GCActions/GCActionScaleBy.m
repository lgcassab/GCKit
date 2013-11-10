//
//  GCActionScaleBy.m
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionScaleBy.h"

@implementation GCActionScaleBy {
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
	
	[UIView animateWithDuration:d
                          delay:0
                        options:(UIViewAnimationOptions)aCurve
                     animations:^ {
						 float a1 = [(UIView *)self.target transform].a;
						 float d1 = [(UIView *)self.target transform].d;
						 
						 CGAffineTransform t;
						 t = CGAffineTransformIdentity;
						 t = CGAffineTransformScale(t, a1 + s, d1 + s);
						 
						 [(UIView *)self.target setTransform:t];
					 }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(actionFinished)];
                     }
     ];
}

- (GCAction *)reverse {
	return [[self class] actionWithDuration:d scale:-s animationCurve:aCurve];
}

@end
