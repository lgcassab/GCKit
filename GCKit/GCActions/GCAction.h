//
//  GCAction.h
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//


@interface GCAction : NSObject {
	
}
@property (nonatomic, readonly, assign) UIView *target;
@property (nonatomic, assign) id sequenceDelegate;

- (void)startWithTarget:(id)target;
- (void)stop;
- (void)actionFinished;

@end

