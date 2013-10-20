//
//  GCAction.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCAction.h"
#import "GCActionManager.h"

@implementation GCAction

- (id)init {
	if ((self=[super init]) ) {
		_target = nil;
		_sequenceDelegate = nil;
	}
	return self;
}

-(void)startWithTarget:(id)aTarget {
	_target = aTarget;
}

-(void)stop {
	_target = nil;
	_sequenceDelegate = nil;
}

-(void)actionFinished {
	if (_sequenceDelegate != nil) {
		if ([_sequenceDelegate respondsToSelector:@selector(lastActionFinished)]) {
			[_sequenceDelegate performSelector:@selector(lastActionFinished)];
		}
	}
	[[GCActionManager sharedManager] removeAction:self];
}

@end