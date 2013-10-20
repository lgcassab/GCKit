//
//  GCAnimationTransition.h
//  GCKit
//
//  Created by Gustavo Cassab on 05/02/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCAnimation.h"

typedef enum {
    kGCTransitionTypeNone,
    kGCTransitionTypeFade,
    kGCTransitionTypeFromBottom,
    kGCTransitionTypeFromLeft,
    kGCTransitionTypeFromRight,
    kGCTransitionTypeFromTop,
    kGCTransitionTypeMoveIn,
    kGCTransitionTypePush,
    kGCTransitionTypeReveal,
} GCTransitionType;

typedef enum {
    kGCTransitionTimingDefault,
    kGCTransitionTimingEasyIn,
    kGCTransitionTimingEaseInEaseOut,
    kGCTransitionTimingEaseOut,
    kGCTransitionTimingLinear,
} GCTransitionTiming;

@interface GCAnimationTransition : GCAnimation {
    
}

+ (id)animationWithDuration:(CGFloat)duration timingFunction:(GCTransitionTiming)timingFunction transitionType:(GCTransitionType )transitionType;

+ (id)animationWithDuration:(CGFloat)duration timingFunction:(GCTransitionTiming)timingFunction transitionType:(GCTransitionType )transitionType transitionSubtype:(GCTransitionType )transitionSubtype;

- (id) initWithDuration:(CGFloat)duration timingFunction:(GCTransitionTiming)timingFunction transitionType:(GCTransitionType )transitionType transitionSubtype:(GCTransitionType )transitionSubtype;

@end
