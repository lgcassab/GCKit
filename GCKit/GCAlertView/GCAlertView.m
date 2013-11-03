//
//  GCAlertView.m
//  GCKit
//
//  Created by Gustavo Cassab on 27/03/12.
//  Copyright (c) 2012 GCCore. All rights reserved.
//

#import "GCAlertView.h"

static GCDismissBlock _dismissBlock;
static GCCancelBlock _cancelBlock;
static GCCompletion _completion;

@interface GCAlertView (GCKit)
@end

@implementation GCAlertView

#pragma mark - Alert with Image

+(id)alertWithImage:(UIImage *)image duration:(CGFloat )duration completion:(GCCompletion)completion {
    GCAlertView *alertView = [[GCAlertView alloc]initWithImage:image duration:duration completion:completion];
    [alertView show];
    return alertView;
}

+(id)alertWithImage:(UIImage *)image duration:(CGFloat )duration {
    GCAlertView *alertView = [[GCAlertView alloc]initWithImage:image duration:duration completion:^{}];
    [alertView show];
    return alertView;
}

-(id)initWithImage:(UIImage *)image duration:(CGFloat )duration completion:(GCCompletion)completion {
    self = [super initWithTitle:@"title" message:@"message" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    if (self) {
        newBodyImage = image;
        newDuration = duration;
        
        _completion  = [completion copy];
        
    }
    return self;
}

#pragma mark - Alert With Color

+ (GCAlertView *) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                          bodyColor:(UIColor *)bodyMessageColor {
    
    return [GCAlertView alertViewWithTitle:title message:message bodyColor:bodyMessageColor cancelButtonTitle:NSLocalizedString(@"OK", @"")];
}

+ (GCAlertView *) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                          bodyColor:(UIColor *)bodyMessageColor
                  cancelButtonTitle:(NSString*) cancelButtonTitle {
    
    GCAlertView *alert = [[GCAlertView alloc] initWithTitle:title
                                                    message:message
                                                  bodyColor:bodyMessageColor
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
    return alert;
}

+ (GCAlertView *) alertViewWithTitle:(NSString*) title                    
                            message:(NSString*) message 
                          bodyColor:(UIColor *)bodyMessageColor
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(GCDismissBlock) dismissed
                           onCancel:(GCCancelBlock) cancelled {
    
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
    
    GCAlertView *alert = [[GCAlertView alloc] initWithTitle:title
                                                    message:message
                                                  bodyColor:bodyMessageColor
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

-(id)initWithTitle:(NSString *)title 
           message:(NSString *)message 
         bodyColor:(UIColor *)bodyMessageColor 
          delegate:(id)delegate 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
 otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        newBodyColor = bodyMessageColor;
    }
    return self;
}

#pragma mark - Overrides

-(id)init {
    self = [super init];
    if (self) {
        newBodyImage = nil;
        newDuration = 0;
    }
    return self;
}

- (void)layoutSubviews {
    
    if (newBodyImage != nil) {
        
        for (UIView *subview in self.subviews) {
            if ([subview isMemberOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)subview;
                [imageView setImage:newBodyImage];
                [imageView setFrame:CGRectMake(0, 0, newBodyImage.size.width, newBodyImage.size.height)];
            } else {
                [subview setHidden:YES];
            }
        }

    } else {
        
        for (UIView *subview in self.subviews) {
            
            if ([subview isMemberOfClass:[UIImageView class]]) { 
                [subview setHidden:YES];
            }
            
            if ([subview isMemberOfClass:[UILabel class]]) { 
                UILabel *label = (UILabel*)subview;	
                label.textColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
                label.shadowColor = [UIColor blackColor];
                label.shadowOffset = CGSizeMake(0.0f, 1.0f);
            }
        }
        
    }
    
}

- (void)drawRect:(CGRect)rect  {
    
    if (newBodyImage != nil)
        return;

	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect  activeBounds = self.bounds;
	CGFloat cornerRadius = 10.0f;	
	CGFloat inset = 6.5f;	
	CGFloat originX = activeBounds.origin.x + inset;
	CGFloat originY = activeBounds.origin.y + inset;
	CGFloat width = activeBounds.size.width - (inset*2.0f);
	CGFloat height = activeBounds.size.height - (inset*2.0f);
    
	CGRect bPathFrame = CGRectMake(originX, originY, width, height);
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:cornerRadius].CGPath;
	
	// Create base shape with fill and shadow
	CGContextAddPath(context, path);
	CGContextSetFillColorWithColor(context, [newBodyColor CGColor]);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 6.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor);
    CGContextDrawPath(context, kCGPathFill);
	
	// Clip State
	CGContextSaveGState(context); //Save Context State Before Clipping To "path"
	CGContextAddPath(context, path);
	CGContextClip(context);
	
	// Draw Gradient
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//	size_t count = 3;
//	CGFloat locations[3] = {0.0f, 0.57f, 1.0f}; 
//	CGFloat components[12] = 
//	{	70.0f/255.0f, 70.0f/255.0f, 70.0f/255.0f, 1.0f,     //1
//		55.0f/255.0f, 55.0f/255.0f, 55.0f/255.0f, 1.0f,     //2
//		40.0f/255.0f, 40.0f/255.0f, 40.0f/255.0f, 1.0f};	//3
//	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
//    
//	CGPoint startPoint = CGPointMake(activeBounds.size.width * 0.5f, 0.0f);
//	CGPoint endPoint = CGPointMake(activeBounds.size.width * 0.5f, activeBounds.size.height);
//    
//	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//	CGColorSpaceRelease(colorSpace);
//	CGGradientRelease(gradient);
	
	// Hatched Background
    CGFloat buttonOffset = 92.5f; 
	CGContextSaveGState(context); 
	CGRect hatchFrame = CGRectMake(0.0f, buttonOffset, activeBounds.size.width, (activeBounds.size.height - buttonOffset+1.0f));
	CGContextClipToRect(context, hatchFrame);
	
	CGFloat spacer = 4.0f;
	int rows = (activeBounds.size.width + activeBounds.size.height/spacer);
	CGFloat padding = 0.0f;
	CGMutablePathRef hatchPath = CGPathCreateMutable();
	for(int i=1; i<=rows; i++) {
		CGPathMoveToPoint(hatchPath, NULL, spacer * i, padding);
		CGPathAddLineToPoint(hatchPath, NULL, padding, spacer * i);
	}
	CGContextAddPath(context, hatchPath);
	CGPathRelease(hatchPath);
	CGContextSetLineWidth(context, 1.0f);
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.15f].CGColor);
	CGContextDrawPath(context, kCGPathStroke);
	CGContextRestoreGState(context); 
	
	// Draw Line
//	CGMutablePathRef linePath = CGPathCreateMutable(); 
//	CGFloat linePathY = (buttonOffset - 1.0f);
//	CGPathMoveToPoint(linePath, NULL, 0.0f, linePathY);
//	CGPathAddLineToPoint(linePath, NULL, activeBounds.size.width, linePathY);
//	CGContextAddPath(context, linePath);
//	CGPathRelease(linePath);
//	CGContextSetLineWidth(context, 1.0f);
//	CGContextSaveGState(context); 
//	CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6f].CGColor);
//	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 0.0f, [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2f].CGColor);
//	CGContextDrawPath(context, kCGPathStroke);
//	CGContextRestoreGState(context); 
	
	//  Stroke path for inner shadow
//	CGContextAddPath(context, path);
//	CGContextSetLineWidth(context, 3.0f);
//	CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);
//	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 6.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor);
//	CGContextDrawPath(context, kCGPathStroke);
    
	// Stroke path to cover up pixilation on corners from clipping
    CGContextRestoreGState(context); 
	CGContextAddPath(context, path);
	CGContextSetLineWidth(context, 3.0f);
	CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 0.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1f].CGColor);
	CGContextDrawPath(context, kCGPathStroke);
	
}

-(void)show {
    [super show];
    
    if (newBodyImage != nil) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, newDuration * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self dismissWithClickedButtonIndex:0 animated:YES];
            if (_completion) {
                _completion();    
            }
            
        });
    }
}

+ (void)alertView:(GCAlertView *) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [alertView cancelButtonIndex]) {
		_cancelBlock();
	} else {
        _dismissBlock(buttonIndex - 1); // cancel button is button 0
    }
}

@end
