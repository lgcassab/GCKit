//
//  NSObject+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 30/07/12.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

@interface NSObject (GCKit) {
	
}

+ (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;

+ (void)cancelBlock:(id)block;

@end
