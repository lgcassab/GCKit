//
//  GCActionFadeIn.m
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionFadeIn.h"

@implementation GCActionFadeIn {
	CGFloat d;
}

+(id)actionWithDuration:(CGFloat)duration {
	return [[self alloc] initWithDuration:duration];
}

-(id)initWithDuration:(CGFloat)duration {
	d = duration;
	return self;
}

-(void)startWithTarget:(id)aTarget {
	
	[super startWithTarget:aTarget];
	
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setAlpha:'", [self.target class] ];
	NSAssert( [self.target respondsToSelector:@selector(setAlpha:)], warningMessage);
	
	[UIView animateWithDuration:d
                          delay:0
                        options:(UIViewAnimationOptions)UIViewAnimationCurveLinear
                     animations:^ {
                         [self.target setAlpha:1];
                     }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(actionFinished)];
                     }
     ];
}

@end
