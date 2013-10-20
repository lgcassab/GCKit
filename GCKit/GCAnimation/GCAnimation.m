//
//  GCAnimation.m
//  GCKit
//
//  Created by Gustavo Cassab on 05/02/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCAnimation.h"

@implementation GCAnimation

- (id)init {
	if ((self=[super init])) {
		_target = nil;
	}
	return self;
}

- (void)startWithTarget:(id)aTarget {
	_target = aTarget;
}

@end
