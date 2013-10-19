//
//  UIScreen+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 12/04/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "UIScreen+GCKit.h"

@implementation UIScreen (GCKit)

+ (CGRect)screenSize {
	CGRect r = [[self mainScreen] bounds];
	return r;
}

+ (BOOL)isRetinaDisplay {
	int scale = 1.0;
	UIScreen *screen = [UIScreen mainScreen];
	if([screen respondsToSelector:@selector(scale)])
		scale = screen.scale;
    
	if(scale == 2.0f)
        return YES;
	else
        return NO;
}

+ (BOOL)isWideScreen {
    return ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON );
}

@end
