//
//  GCBarButtonImage.m
//  GCKit
//
//  Created by Gustavo Cassab on 20/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCBarButtonImageItem.h"

@interface GCBarButtonImageItem (Private)
-(id)initWithTarget:(id)aTarget action:(SEL)anAction normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;
@end

@implementation GCBarButtonImageItem

+(id)buttonWithTarget:(id)aTarget action:(SEL)anAction normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
	return [[self alloc]initWithTarget:aTarget action:anAction normalImage:normalImage selectedImage:selectedImage];
}

-(id)initWithTarget:(id)aTarget action:(SEL)anAction normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
	
	_aButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_aButton setFrame:CGRectMake(-50, -10, normalImage.size.width, selectedImage.size.height)];
	[_aButton setImage:normalImage forState:UIControlStateNormal];
	[_aButton setImage:selectedImage forState:UIControlStateHighlighted];
	[_aButton addTarget:aTarget action:anAction forControlEvents:UIControlEventTouchUpInside];
	
	self = [super initWithCustomView:_aButton];
	
	return self;
}

-(void)setHidden:(BOOL)hidden {
	[self.customView setHidden:hidden];
}

@end
