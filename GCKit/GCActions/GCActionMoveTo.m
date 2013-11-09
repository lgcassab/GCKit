//
//  GCActionMoveTo.m
//  GCKit
//
//  Created by Gustavo Cassab on 13/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionMoveTo.h"

@implementation GCActionMoveTo {
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
    
    [UIView animateWithDuration:d 
                          delay:0 
                        options:(UIViewAnimationOptions)aCurve
                     animations:^ {
                         [self.target setCenter:p];
                     } 
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(actionFinished)];
                     }
     ];
}

@end
