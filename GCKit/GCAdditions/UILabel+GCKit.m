//
//  UILabel+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 12/04/14.
//  Copyright (c) 2014 GCCore Digital Technologies. All rights reserved.
//

#import "UILabel+GCKit.h"
#import "UIView+GCKit.h"

@implementation UILabel (GCKit)

- (void)adjustHeight {
	
	CGSize size = CGSizeMake(0, 0);
	
	#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000 
	size = [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT)
								   options:NSStringDrawingUsesLineFragmentOrigin
								attributes:@{NSFontAttributeName:self.font}
								   context:nil].size;
	#else
	size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.width, FLT_MAX)];
	#endif
	
	[self setHeight:size.height];
}

@end
