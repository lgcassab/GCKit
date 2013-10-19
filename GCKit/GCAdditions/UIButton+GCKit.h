//
//  UIButton+GCKit.h
//  GCKit
//
//  Created by Gustavo Cassab on 17/07/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^UIButtonBlock)();

@interface UIButton (GCKit) {
	
}

- (void)handleControlEvent:(UIControlEvents)event withBlock:(UIButtonBlock)block;
- (void)callActionBlock:(id)sender;

+ (UIButton *)buttonWithImage:(NSString *)pImageName
				selectedImage:(NSString *)pSelectedImage
					   target:(id)pTarget
		   selectorToBeCalled:(SEL)pSel;

@end
