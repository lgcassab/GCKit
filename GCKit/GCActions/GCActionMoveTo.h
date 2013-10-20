//
//  GCActionMoveTo.h
//  GCKit
//
//  Created by Gustavo Cassab on 13/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCAction.h"

@interface GCActionMoveTo : GCAction {
	
}

+ (id)actionWithDuration:(CGFloat)duration position:(CGPoint)position;
+ (id)actionWithDuration:(CGFloat)duration position:(CGPoint)position animationCurve:(UIViewAnimationCurve)animationCurve;

@end
