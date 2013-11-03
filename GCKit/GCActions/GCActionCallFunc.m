//
//  GCActionCallFunc.m
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionCallFunc.h"

@implementation GCActionCallFunc {
	id funcTarget;
	SEL funcSelector;
}

+ (id)actionWithTarget:(id)cfTarget selector:(SEL)selector {
	return [[self alloc]initWithTarget:cfTarget selector:selector];
}

- (id)initWithTarget:(id)cfTarget selector:(SEL)selector {
	
	funcTarget = cfTarget;
	funcSelector = selector;
	
	return self;
}

- (void)startWithTarget:(id)aTarget {
	[super startWithTarget:aTarget];
	
	#pragma clang diagnostic push
	#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	if (funcTarget) {
		if ([funcTarget respondsToSelector:funcSelector]) {
			[funcTarget performSelector:funcSelector];
		}
	}
	#pragma clang diagnostic pop
}

@end
