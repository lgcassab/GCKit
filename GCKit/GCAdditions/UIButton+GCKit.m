//
//  UIButton+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 17/07/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "UIButton+GCKit.h"

static UIButtonBlock _UIButtonBlock;

@implementation UIButton (GCKit)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(UIButtonBlock)block {
    _UIButtonBlock = block;
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)callActionBlock:(id)sender {
    _UIButtonBlock();
}

+ (UIButton *)buttonWithImage:(NSString *)pImageName
				selectedImage:(NSString *)pSelectedImage
					   target:(id)pTarget
		   selectorToBeCalled:(SEL)pSel {
    
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *homeImage = [UIImage imageNamed:pImageName];
	UIImage *selectedImage = [UIImage imageNamed:pSelectedImage];
	
	[button setImage:homeImage forState:UIControlStateNormal];
	[button setImage:selectedImage forState:UIControlStateSelected];
	[button setImage:selectedImage forState:UIControlStateHighlighted];
	[button addTarget:pTarget action:pSel forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, homeImage.size.width, homeImage.size.height)];
    
	return button;
}

@end
