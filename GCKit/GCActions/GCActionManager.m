//
//  GCActionManager.m
//  GCKit
//
//  Created by Gustavo Cassab on 20/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCActionManager.h"

@interface GCActionManager ( )
@property(nonatomic, strong) NSMutableArray *arrayActions;
@end

static GCActionManager *sharedManager = nil;

@implementation GCActionManager

#pragma mark - Class Methods

+ (GCActionManager *)sharedManager {
	static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedManager = [[GCActionManager alloc] init];
    });
    return sharedManager;
}

+ (id)alloc {
	NSAssert(sharedManager == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

#pragma mark - Public Methods

- (id) init {
	_arrayActions = [NSMutableArray new];
	return self;
}

- (void)addAction:(GCAction *)action target:(id)target {
	
	NSAssert( action != nil, @"Argument action must be non-nil");
	NSAssert( target != nil, @"Argument target must be non-nil");	

	[_arrayActions addObject:action];
	[action startWithTarget:target];
}

- (void)removeActionWithTarget:(id)target {
	for (GCAction *action in _arrayActions) {
		if ([action target] == target) {
			[_arrayActions removeObject:action];
			break;
		}
	}
}

- (void)removeAction:(id)action {
	for (GCAction *act in _arrayActions) {
		if (act == action) {
			[_arrayActions removeObject:action];
			break;
		}
	}
}

@end
