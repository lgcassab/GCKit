//
//  GCEffect.h
//  GCKit
//
//  Created by Gustavo Cassab on 03/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface GCEffect : NSObject {

}
@property (nonatomic, readonly, assign) id target;

- (void)runEffectInView:(UIView *)view;
- (void)removeEffectFromView:(UIView *)view;

@end
