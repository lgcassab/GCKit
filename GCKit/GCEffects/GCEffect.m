//
//  GCEffect.m
//  GCKit
//
//  Created by Gustavo Cassab on 03/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "GCEffect.h"

@implementation GCEffect

-(id) init {
	if ((self=[super init]) ) {
		_target = nil;
	}
	return self;
}

- (void)runEffectInView:(UIView *)view {
	_target = view;
}

- (void)removeEffectFromView:(UIView *)view {
	_target = view;
}

@end
