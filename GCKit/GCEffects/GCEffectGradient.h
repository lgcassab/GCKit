//
//  GCEffectGradient.h
//  GCKit
//
//  Created by Gustavo Cassab on 05/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCEffect.h"

@interface GCEffectGradient : GCEffect {

}

+ (id)gradientWithTopColor:(UIColor *)_topColor bottomColor:(UIColor *)_bottomColor;

@end
