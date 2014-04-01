//
//  UITextField+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 24/08/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "UITextField+GCKit.h"
#import "GCTextFieldDelegate.h"
#import <objc/runtime.h>

NSString * const kMaskKey = @"kMaskKey";
NSString * const kMaskDelegateKey = @"kMaskDelegateKey";

@implementation UITextField (GCKit)
@dynamic mask, maskDelegate;

#pragma mark - Mask

- (void)setMask:(id)aObject {
    objc_setAssociatedObject(self, (__bridge const void *)(kMaskKey), aObject, OBJC_ASSOCIATION_ASSIGN);
	if (self.delegate) {
		[self setMaskDelegate:self.delegate];
		[self setDelegate:[GCTextFieldDelegate sharedDelegate]];
	}
//    [self addObserver:self forKeyPath:@"delegate" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSString *)mask {
    return objc_getAssociatedObject(self, (__bridge const void *)(kMaskKey));
}

#pragma mark - MaskDelegate

- (void)setMaskDelegate:(id)aObject {
    objc_setAssociatedObject(self, (__bridge const void *)(kMaskDelegateKey), aObject, OBJC_ASSOCIATION_ASSIGN);
}

- (id)maskDelegate {
    return objc_getAssociatedObject(self, (__bridge const void *)(kMaskDelegateKey));
}

#pragma mark - Observer

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//	if ([keyPath isEqual:@"delegate"]) {
//        if (![self.delegate isKindOfClass:[GCTextFieldDelegate class]]) {
//            [self setMaskDelegate:self.delegate];
//            [self setDelegate:[GCTextFieldDelegate sharedDelegate]];
//        }
//    }
//}


#pragma mark - Memory Managment

-(void)removeFromSuperview {
    
//    if (self.mask)
//        [self removeObserver:self forKeyPath:@"delegate"];
    
    objc_setAssociatedObject(self, (__bridge const void *)(kMaskKey), nil, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, (__bridge const void *)(kMaskDelegateKey), nil, OBJC_ASSOCIATION_ASSIGN);
    
    [self setMask:nil];
    [self setMaskDelegate:nil];
    
    [super removeFromSuperview];
}

@end
