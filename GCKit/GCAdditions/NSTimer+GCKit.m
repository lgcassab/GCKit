//
//  NSTimer+GCKit.m
//  Becker-Core
//
//  Created by Gustavo Cassab on 01/10/13.
//  Copyright (c) 2013 GCCore Digital Technologies. All rights reserved.
//

#import "NSTimer+GCKit.h"
#import <objc/runtime.h>

@interface NSTimer ( )
@property (nonatomic) NSNumber *timeDeltaNumber;
@end

@implementation NSTimer (GCKit)

static void *AssociationKey;

- (NSNumber *)timeDeltaNumber {
    return objc_getAssociatedObject(self, AssociationKey);
}

- (void)setTimeDeltaNumber:(NSNumber *)timeDeltaNumber {
    objc_setAssociatedObject(self, AssociationKey, timeDeltaNumber, OBJC_ASSOCIATION_RETAIN);
}

- (void)pause {
    
    if ([self isPaused])
        return;
    
    NSTimeInterval interval = [[self fireDate] timeIntervalSinceNow];
    self.timeDeltaNumber = @(interval);
    self.fireDate = [NSDate distantFuture];
}

- (void)resume {
    
    if (![self isPaused])
        return;
    
    self.fireDate = [[NSDate date] dateByAddingTimeInterval:[self.timeDeltaNumber doubleValue]];
    self.timeDeltaNumber = nil;
}

- (BOOL)isPaused {
    return (self.timeDeltaNumber != nil);
}

@end
