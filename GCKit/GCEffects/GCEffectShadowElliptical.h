//
//  GCEffectShadowElliptical.h
//  GCKit
//
//  Created by Gustavo Cassab on 03/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCEffect.h"

@interface GCEffectShadowElliptical : GCEffect {
	
}

+ (id)effect;
+ (id)shadowWithColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius;

@end
