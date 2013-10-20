//
//  GCActionDelay.m
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionDelay.h"

@implementation GCActionDelay {
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
	[self performSelector:@selector(actionFinished) withObject:nil afterDelay:d];
}

@end
