//
//  GCActionRotateBy.h
//  GCKit
//
//  Created by Gustavo Cassab on 13/12/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCAction.h"

@interface GCActionRotateBy : GCAction {
	
}

+ (id)actionWithDuration:(CGFloat)duration angle:(CGFloat)angle;
+ (id)actionWithDuration:(CGFloat)duration angle:(CGFloat)angle animationCurve:(UIViewAnimationCurve)animationCurve;

- (GCAction *)reverse;

@end
