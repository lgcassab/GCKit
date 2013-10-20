//
//  GCEffectBorder.h
//  GCKit
//
//  Created by Gustavo Cassab on 03/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCEffect.h"

@interface GCEffectBorder : GCEffect {
	
}

+ (id)effect;
+ (id)borderWithColor:(UIColor *)color width:(CGFloat)width;

@end
