//
//  UIView+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 19/10/10.
//  Copyright 2010 GCCore Digital Technologies. All rights reserved.
//

#import "UIView+GCKit.h"
#import "GCBadgeView.h"
#import "GCEffect.h"
#import "GCAnimation.h"

@implementation UIView (GCKit)

- (GCAction *)runAction:(GCAction *)action {
	
	NSAssert( action != nil, @"Argument must be non-nil");
	
	[[GCActionManager sharedManager] addAction:action target:self];
	return action;
}

- (void)setScale:(CGFloat)scale {
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setTransform:'", [self class] ];
	NSAssert( [self respondsToSelector:@selector(setTransform:)], warningMessage);	
	
	CGAffineTransform t;
	t = CGAffineTransformIdentity;
	t = CGAffineTransformScale(t, scale, scale);
	[self setTransform:t];
}

- (void)setOpacity:(CGFloat)opacity {
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setAlpha:'", [self class] ];
	NSAssert( [self respondsToSelector:@selector(setAlpha:)], warningMessage);	

	[self setAlpha:opacity];
}

- (void)setPosition:(CGPoint)position {
	NSString *warningMessage = [NSString stringWithFormat:@"Target '%@' does not responds to 'setCenter:'", [self class] ];
	NSAssert( [self respondsToSelector:@selector(setCenter:)], warningMessage);	
	
	[self setCenter:position];
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}


- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)centerX {
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)ttScreenX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
	}
	return x;
}

- (CGFloat)ttScreenY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
	}
	return y;
}

- (CGFloat)screenViewX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	
	return x;
}

- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGRect)screenFrame {
	return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (void)removeAllSubviews {
	while (self.subviews.count) {
		UIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (UIView *)subviewWithTag:(int)tag {
	
	for (UIView* child in self.subviews) {
		if (child.tag == tag) {
            return child;
        }
	}
	
	return nil;
}

- (UIView *)descendantOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls])
		return self;
	
	for (UIView* child in self.subviews) {
		UIView* it = [child descendantOrSelfWithClass:cls];
		if (it)
			return it;
	}
	
	return nil;
}

- (UIView *)ancestorOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls]) {
		return self;
	} else if (self.superview) {
		return [self.superview ancestorOrSelfWithClass:cls];
	} else {
		return nil;
	}
}

- (UIView *)viewWithKindOfClass:(Class)aClass {
    NSMutableArray* nodeQueue = [NSMutableArray arrayWithObject:self];
    
    while ([nodeQueue count] > 0) {
        
        UIView* node = [nodeQueue objectAtIndex:0];
        [nodeQueue removeObjectAtIndex:0];
        
        if ([node isKindOfClass:aClass])
            return node;
        else
            [nodeQueue addObjectsFromArray:node.subviews];
    }
    
    return nil;
}

- (CGPoint)offsetFromView:(UIView*)otherView {
	CGFloat x = 0, y = 0;
	for (UIView* view = self; view && view != otherView; view = view.superview) {
		x += view.left;
		y += view.top;
	}
	return CGPointMake(x, y);
}

- (UIViewController *)viewController {
	for (UIView* next = [self superview]; next; next = next.superview) {
		UIResponder* nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]]) {
			return (UIViewController*)nextResponder;
		}
	}
	return nil;
}

#pragma mark - Badge

-(GCBadgeView *)badge {
	UIView *existingBadge = [self viewWithTag:kGCBadgeGlobalTab];
	
	if(existingBadge) {
		if(![existingBadge isKindOfClass:[GCBadgeView class]]) {
			NSLog(@"Unexpected view of class %@ found with badge tag." , [existingBadge class] );
			return nil;
		} else {
			return (GCBadgeView *)existingBadge;
		}
	}
	
	GCBadgeView *badgeView = [[GCBadgeView alloc]initWithFrame:CGRectZero];
	[badgeView setTag:kGCBadgeGlobalTab];
	[self addSubview:badgeView];
	
	return badgeView;
}

#pragma mark - GCEffects

- (void)addEffect:(GCEffect *)effect {
	[effect runEffectInView:self];
}

- (void)removeEffect:(GCEffect *)effect {
	[effect removeEffectFromView:self];
}

#pragma mark - GCAnimation

- (void)addAnimation:(GCAnimation *)animation {
    [animation startWithTarget:self];
}

#pragma mark - Render

-(UIImage *)renderImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

#pragma mark - Animations

- (void)removeWithTransition:(UIViewAnimationTransition)transition andDuration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition:transition forView:self.superview cache:YES];
	[self removeFromSuperview];
	[UIView commitAnimations];
}

- (void)addSubview:(UIView *)view withTransition:(UIViewAnimationTransition)transition withDuration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition:transition forView:self cache:YES];
	[self addSubview:view];
	[UIView commitAnimations];
}

- (void)setFrame:(CGRect)fr withDuration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	self.frame = fr;
	[UIView commitAnimations];
}

- (void)setAlpha:(float)a withDuration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	self.alpha = a;
	[UIView commitAnimations];
}

#pragma mark - Color

- (UIColor *)colorAtPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
	CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
	CGContextTranslateCTM(context, -point.x, -point.y);
    
	[self.layer renderInContext:context];
    
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
	return color;
}

@end
