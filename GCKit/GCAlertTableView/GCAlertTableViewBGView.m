//
//  UITableViewAlertViewTableViewBackgroundView.m
//  GCKit

#import "GCAlertTableViewBGView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GCAlertTableViewBGView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.needsDisplayOnBoundsChange = YES;
        
        UIColor *startColor = [UIColor whiteColor];
        UIColor *endColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGFloat locations[] = { 0.0, 1.0 };
        
        NSArray *colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
        
        _gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
        
        CGColorSpaceRelease(colorSpace);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(super.bounds), CGRectGetMinY(super.bounds));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(super.bounds), CGRectGetMaxY(super.bounds));
	
	CGContextDrawLinearGradient(context, _gradient, startPoint, endPoint, 0);
}

- (void)dealloc {
    if (_gradient) {
        CGGradientRelease(_gradient);
    }
}

@end
