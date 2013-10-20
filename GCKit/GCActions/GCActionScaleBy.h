//
//  GCActionScaleBy.h
//  GCKit
//
//  Created by Gustavo Cassab on 18/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCAction.h"

@interface GCActionScaleBy : GCAction {
	
}

+ (id)actionWithDuration:(CGFloat)duration scale:(CGFloat)scale;
+ (id)actionWithDuration:(CGFloat)duration scale:(CGFloat)scale animationCurve:(UIViewAnimationCurve)animationCurve;

- (GCAction *)reverse;

@end
