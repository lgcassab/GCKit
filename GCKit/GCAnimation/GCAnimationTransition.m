//
//  GCAnimationTransition.m
//  GCKit
//
//  Created by Gustavo Cassab on 05/02/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCAnimationTransition.h"

@implementation GCAnimationTransition {
	CGFloat _duration;
    GCTransitionTiming _timingFunction;
    GCTransitionType _transitionType;
    GCTransitionType _transitionSubtype;
}

+ (id)animationWithDuration:(CGFloat)duration
			 timingFunction:(GCTransitionTiming)timingFunction
			 transitionType:(GCTransitionType )transitionType {
	
    return [[self alloc] initWithDuration:duration timingFunction:timingFunction transitionType:transitionType transitionSubtype:kGCTransitionTypeNone];
}

+ (id)animationWithDuration:(CGFloat)duration
			 timingFunction:(GCTransitionTiming)timingFunction
			 transitionType:(GCTransitionType )transitionType
		  transitionSubtype:(GCTransitionType )transitionSubtype {
	
    return [[self alloc] initWithDuration:duration timingFunction:timingFunction transitionType:transitionType transitionSubtype:transitionSubtype];
}

- (id) initWithDuration:(CGFloat)duration
		 timingFunction:(GCTransitionTiming)timingFunction
		 transitionType:(GCTransitionType )transitionType
	  transitionSubtype:(GCTransitionType )transitionSubtype {
	
	if( (self=[super init]) ) {	
        _duration           = duration;
        _timingFunction     = timingFunction;
        _transitionType     = transitionType;
        _transitionSubtype  = transitionSubtype;
	}
	
	return self;
}

- (void)startWithTarget:(id)aTarget {
    [super startWithTarget:aTarget];

    NSString *newTimingFunction     = nil;        
    NSString *newTransitionType     = nil;
    NSString *newTransitionSubtype  = nil;    
    
    switch (_timingFunction) {
        case kGCTransitionTimingDefault:        { newTimingFunction = kCAMediaTimingFunctionDefault; break; }
        case kGCTransitionTimingEasyIn:         { newTimingFunction = kCAMediaTimingFunctionEaseIn; break; }
        case kGCTransitionTimingEaseInEaseOut:  { newTimingFunction = kCAMediaTimingFunctionEaseInEaseOut; break; }
        case kGCTransitionTimingEaseOut:        { newTimingFunction = kCAMediaTimingFunctionEaseOut; break; }
        case kGCTransitionTimingLinear:         { newTimingFunction = kCAMediaTimingFunctionLinear; break; }
    }
    
    switch (_transitionType) {
        case kGCTransitionTypeNone:         { break; }            
        case kGCTransitionTypeFade:         { newTransitionType = kCATransitionFade; break; }
        case kGCTransitionTypeFromBottom:   { newTransitionType = kCATransitionFromBottom; break; }
        case kGCTransitionTypeFromLeft:     { newTransitionType = kCATransitionFromLeft; break; }
        case kGCTransitionTypeFromRight:    { newTransitionType = kCATransitionFromRight; break; }
        case kGCTransitionTypeFromTop:      { newTransitionType = kCATransitionFromTop; break; }
        case kGCTransitionTypeMoveIn:       { newTransitionType = kCATransitionMoveIn; break; }
        case kGCTransitionTypePush:         { newTransitionType = kCATransitionPush; break; }
        case kGCTransitionTypeReveal:       { newTransitionType = kCATransitionReveal; break; }
    }
    
    switch (_transitionSubtype) {
        case kGCTransitionTypeNone:         { break; }            
        case kGCTransitionTypeFade:         { newTransitionSubtype = kCATransitionFade; break; }
        case kGCTransitionTypeFromBottom:   { newTransitionSubtype = kCATransitionFromBottom; break; }
        case kGCTransitionTypeFromLeft:     { newTransitionSubtype = kCATransitionFromLeft; break; }
        case kGCTransitionTypeFromRight:    { newTransitionSubtype = kCATransitionFromRight; break; }
        case kGCTransitionTypeFromTop:      { newTransitionSubtype = kCATransitionFromTop; break; }
        case kGCTransitionTypeMoveIn:       { newTransitionSubtype = kCATransitionMoveIn; break; }
        case kGCTransitionTypePush:         { newTransitionSubtype = kCATransitionPush; break; }
        case kGCTransitionTypeReveal:       { newTransitionSubtype = kCATransitionReveal; break; }
    }
    
    CATransition *transition = [CATransition animation];
    [transition setDuration:_duration];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:newTimingFunction]];
    [transition setType:newTransitionType];
    [transition setSubtype:newTransitionSubtype];

	[[aTarget layer] addAnimation:transition forKey:nil];
}

@end
