//
//  UIView+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "GCBadgeView.h"
#import "GCActionManager.h"
#import "GCEffectGlobal.h"

@class GCEffect;

@class GCBadgeView;

@interface UIView (GCKit)

- (GCAction *)runAction:(GCAction *)action;

- (void)addEffect:(GCEffect *)effect;
- (void)removeEffect:(GCEffect *)effect;

//- (void)addAnimation:(GCAnimation *)animation;

- (void)setScale:(CGFloat)scale;
- (void)setOpacity:(CGFloat)opacity;
- (void)setPosition:(CGPoint)position;

@property (nonatomic) CGFloat left;		// Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;		// Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;	// Shortcut for frame.origin.y
@property (nonatomic) CGFloat bottom;	// Shortcut for frame.origin.y
@property (nonatomic) CGFloat width;	// Shortcut for frame.size.width
@property (nonatomic) CGFloat height;	// Shortcut for frame.size.height
@property (nonatomic) CGFloat centerX;	// Shortcut for center.x
@property (nonatomic) CGFloat centerY;	// Shortcut for center.y
@property (nonatomic, readonly) CGFloat ttScreenX;		// Return the x coordinate on the screen.
@property (nonatomic, readonly) CGFloat ttScreenY;		// Return the y coordinate on the screen.
@property (nonatomic, readonly) CGFloat screenViewX;	// Return the x coordinate on the screen, taking into account scroll views.
@property (nonatomic, readonly) CGFloat screenViewY;	// Return the y coordinate on the screen, taking into account scroll views.
@property (nonatomic, readonly) CGRect screenFrame;		// Return the view frame on the screen, taking into account scroll views.
@property (nonatomic) CGPoint origin;	// Shortcut for frame.origin
@property (nonatomic) CGSize size;		// Shortcut for frame.size
@property(nonatomic, readonly) GCBadgeView *badge;

- (UIView *)descendantOrSelfWithClass:(Class)cls; // Finds the first descendant view (including this view) that is a member of a particular class.
- (UIView *)ancestorOrSelfWithClass:(Class)cls; // Finds the first ancestor view (including this view) that is a member of a particular class.
- (UIView*)viewWithKindOfClass:(Class)aClass;

- (void)removeAllSubviews; //Removes all subviews.

- (CGPoint)offsetFromView:(UIView*)otherView; // Calculates the offset of this view from another view in screen coordinates. otherView should be a parent view of this view.
- (UIViewController*)viewController; // The view controller whose view contains this view.

- (UIImage *)renderImage;

- (UIView*)subviewWithTag:(int)tag;

// Animate removing a view from its parent
- (void)removeWithTransition:(UIViewAnimationTransition) transition andDuration:(float) duration;
// Animate adding a subview
- (void)addSubview:(UIView *)view withTransition:(UIViewAnimationTransition) transition withDuration:(float) duration;
// Animate the changing of a views frame
- (void)setFrame:(CGRect)fr withDuration:(float) duration;
// Animate changing the alpha of a view
- (void)setAlpha:(float)a withDuration:(float) duration;

- (UIColor *)colorAtPoint:(CGPoint)point;

@end
