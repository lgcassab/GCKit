//
//  GCActionSequence.m
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionSequence.h"
#import "UIView+GCKit.h"

@implementation GCActionSequence

+ (id)actions:(GCAction *)action1, ... {
	
	NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
	
	va_list params;
	va_start(params,action1);
	
	GCAction *now;
	[tmpArray addObject:action1];
	
	while( action1 ) {
		
		now = va_arg(params, GCAction *);
		
		if (!now )
			break;
		else
			[tmpArray addObject:now];
		
	}
	
	va_end(params);
	
	return [[self alloc] initWithArray:tmpArray];
}

- (id)initWithArray:(NSMutableArray *)array {
	
	_arrayActions = [NSMutableArray new];
	for (GCAction *action in array) {
		[_arrayActions addObject:action];
	}
	
	return self;
}

- (void)startWithTarget:(id)aTarget {
	[super startWithTarget:aTarget];
	[self runNextAction];
}

- (void)runNextAction {
	if ([_arrayActions count] > 0) {
		GCAction *action = [_arrayActions objectAtIndex:0];
		[action setSequenceDelegate:self];
		[self.target runAction:action];
	}
}
 
- (void)lastActionFinished {
	if ([_arrayActions count] > 0)
		[_arrayActions removeObjectAtIndex:0];
	[self runNextAction];
}

@end
