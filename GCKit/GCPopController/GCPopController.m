//
//  GCPopController.m
//  GCKit
//
//  Created by Gustavo Cassab on 09/02/12.
//  Copyright (c) 2012 GCCore Digital Technologies. All rights reserved.
//

#import "GCPopController.h"

@interface GCPopController ( )
@end

static GCPopController *sharedController = nil;

@implementation GCPopController
@synthesize popoverController;

+ (GCPopController *)sharedController {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedController = [[GCPopController alloc] init];
    });
    return sharedController;
}

- (id) init {
	if (!self.popoverController) {
		self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self];
		[self.popoverController setDelegate:self];
	}
	return self;
}

+ (id)alloc {
	NSAssert(sharedController == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

#pragma mark - PopController methods

- (void)dismiss {
	[self.popoverController dismissPopoverAnimated:YES];
}

- (void)showViewController:(UIViewController *)viewController fromBarButtonItem:(UIBarButtonItem *)button {
	
	[self.popoverController setContentViewController:viewController animated:YES];
    [self.popoverController setPopoverContentSize:viewController.contentSizeForViewInPopover];
	
	[self.popoverController presentPopoverFromBarButtonItem:button
							   permittedArrowDirections:UIPopoverArrowDirectionAny
											   animated:YES];
}

- (void)showViewController:(UIViewController *)viewController fromButton:(UIButton *)button {
	
	[self.popoverController setContentViewController:viewController animated:YES];
    [self.popoverController setPopoverContentSize:viewController.contentSizeForViewInPopover];
    
	[self.popoverController presentPopoverFromRect:button.frame
										inView:button.superview
					  permittedArrowDirections:UIPopoverArrowDirectionAny
									  animated:YES];
    
}

- (void)showViewController:(UIViewController *)viewController fromButton:(UIButton *)button arrowDirection:(UIPopoverArrowDirection)arrow {
	
	[self.popoverController setContentViewController:viewController animated:YES];
    [self.popoverController setPopoverContentSize:viewController.contentSizeForViewInPopover];
	
	[self.popoverController presentPopoverFromRect:button.frame
										inView:button.superview
					  permittedArrowDirections:arrow
									  animated:YES];
}

- (void)showViewController:(UIViewController *)viewController fromFrame:(CGRect)frame inView:(UIView *)view {
	[self showViewController:viewController fromFrame:frame inView:view arrowDirection:UIPopoverArrowDirectionAny];
}

- (void)showViewController:(UIViewController *)viewController fromFrame:(CGRect)frame inView:(UIView *)view arrowDirection:(UIPopoverArrowDirection)arrow {
	
	[self.popoverController setContentViewController:viewController animated:YES];
    [self.popoverController setPopoverContentSize:viewController.contentSizeForViewInPopover];
	
	[self.popoverController presentPopoverFromRect:frame
										inView:view
					  permittedArrowDirections:arrow
									  animated:YES];
}

#pragma mark - UIPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)nPopoverController {
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(gcPopoverDismissedSuccessfuly)]) {
            [_delegate gcPopoverDismissedSuccessfuly];
            _delegate = nil;
        };
    }
}

@end
